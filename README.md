# torch-validator

Given a network and a csv file with validation data, this package validates
the network and assigns it a performance score.

## Automatically validating a deepkeep package

Add the following to your networks `package.json`:
```json
...
  "validators": [
    {
      "name": "deepkeep/torch-validator",
      "packages": {
        "validation-data": "deepkeep/xor-validation-data"
      }
    }
  ]
...
```

This will automatically run the `torch-validator` on that package when it's
uploaded, using `deepkeep/xor-validation-data` as the validation dataset.

## Running locally

```sh
docker run -v /path/to/network:/packages/network -v /path/to/validation-data:/packages/validation-data docker.deepkeep.co/deepkeep/torch-validator
```
