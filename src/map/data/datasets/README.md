# Adding a dataset

Each dataset is a small vertical slice:

```text
datasets/<name>/
  dataset.h
  dataset.cpp
  yaml.h
```

Use plural, snake-case names such as `status_effects` and `ecosystems`.

## Files
### `dataset.h`
- `dataset.h` contains the types used by gameplay code and the `Dataset` descriptor.
- Keep this header free of Glaze includes.
- Forward-declare the root YAML type and expose:

```cpp
struct Dataset
{
    using Records      = MyRecords;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "my_records" };
    static constexpr std::string_view kTitle{ "My Records" };
    static constexpr std::string_view kDescription{ "What this dataset controls." };

    static auto decode(std::string_view text) -> Records;
};
```

### `yaml.h`
- `yaml.h` contains the wire types read from YAML and their Glaze schema annotations.
- YAML-facing fields use snake case.
- Use `yaml::EnumToken<T>` for named enums and `std::optional` where omission or explicit `null` has meaning.
- Mark the payload member with `using YamlRoot = yaml::DatasetRoot<&MyFile::my_records>;`
  so the shared reader ignores optional `meta` codegen directives. Describe
  maps keyed by record name with ordinary `glz::schema` annotations.

### `dataset.cpp`
- `dataset.cpp` performs the explicit wire-to-gameplay conversion.
- This is where defaults, enum resolution, key/ID checks, duplicate-ID checks, and any dataset-specific validation belong.

## Registration

Add the dataset in two places:

1. Add `add_data_dataset(<name>)` to `src/map/data/CMakeLists.txt`.
2. Add the `Dataset` type to `src/map/data/datasets/catalog.h`.

The catalog drives both schema generation and production-data verification.

## Data and tests

Add `data/<name>.yaml` with the generated schema directive at the top:

```yaml
# yaml-language-server: $schema=schemas/<name>.schema.json
```

Build and validate with:

```sh
cmake --build build --target data_schema_check
```

This decodes the production YAML, generates `data/schemas/<name>.schema.json`, and validates the YAML against it. Generated dataset schemas are local build output and are not committed.
