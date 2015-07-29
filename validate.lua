require 'torch'
require 'nn'
require 'nngraph'
local csv2tensor = require 'csv2tensor'
local cjson = require 'cjson'

-- Load network and validation data
local net = torch.load(os.getenv('NETWORK'))
local validationData, columnNames = csv2tensor.load(os.getenv('VALIDATION_DATA'))

-- Find index of expect output values (the first column of the expected outputs
-- is always expected to start with a y)
local yIndex = 1
while not (columnNames[yIndex]:sub(1, 1) == 'y') do yIndex = yIndex + 1 end

local criterion = nn.MSECriterion()

-- Let's run through the validation data and compute an average error
local err = 0
for i=1, validationData:size(1) do
  local x = validationData:sub(i, i, 1, yIndex - 1)
  local y = validationData:sub(i, i, yIndex, validationData:size(2))
  local yp = net:forward(x)
  local e = criterion:forward(yp, y)
  print('###' .. cjson.encode({
    event='data-point',
    x=torch.totable(x),
    y=torch.totable(y),
    yp=torch.totable(yp),
    err=e
  }))
  err = err + e
end
err = err / validationData:size(1)

-- Finally output the score of this network. The system will parse this number
-- and display it on the networks page in deepkeep.
print('###' .. cjson.encode({
  event='score',
  score=err
}))
