/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "data/datasets/catalog.h"
#include "data/yaml/merge.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <exception>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>

namespace xi::data::schema
{

namespace
{

using Object = glz::generic::object_t;

auto serializeSchema(glz::generic document, const std::string& id, const std::string_view title, const std::string_view description) -> std::string
{
    auto* root = document.get_if<Object>();
    if (!root)
    {
        throw std::runtime_error("Glaze generated a non-object schema");
    }

    const auto propertyEntry = root->find("properties");
    auto*      properties    = propertyEntry == root->end() ? nullptr : propertyEntry->second.get_if<Object>();
    if (!properties)
    {
        throw std::runtime_error("dataset schema has no properties");
    }

    properties->erase("meta");
    (*properties)["meta"]["$ref"] = "_meta.schema.json";

    if (const auto definitions = root->find("$defs"); definitions != root->end())
    {
        if (auto* values = definitions->second.get_if<Object>())
        {
            values->erase("glz::skip");
        }
    }

    Object ordered;
    ordered["$schema"]     = "https://json-schema.org/draft/2020-12/schema";
    ordered["$id"]         = id;
    ordered["title"]       = title;
    ordered["description"] = description;
    for (auto& [key, value] : *root)
    {
        if (key != "$schema" && key != "$id" && key != "title" && key != "description")
        {
            ordered[key] = std::move(value);
        }
    }
    document.data = std::move(ordered);

    auto output = glz::write<glz::opts{ .prettify = true }>(document);
    if (!output)
    {
        throw std::runtime_error("Glaze could not serialize schema");
    }

    output->push_back('\n');
    return *output;
}

template <class T>
auto readSchema() -> glz::generic
{
    auto text = glz::write_json_schema<T, glz::opts{ .error_on_missing_keys = true }>();
    if (!text)
    {
        throw std::runtime_error("Glaze could not generate schema");
    }

    glz::generic document;
    if (const auto error = glz::read_json(document, *text))
    {
        throw std::runtime_error(glz::format_error(error, *text));
    }

    return document;
}

template <datasets::DatasetDefinition Dataset>
auto makeDatasetSchema() -> std::string
{
    return serializeSchema(readSchema<typename Dataset::YamlDocument>(),
                           std::string{ Dataset::kDataPath } + ".schema.json",
                           Dataset::kTitle,
                           Dataset::kDescription);
}

template <datasets::DatasetDefinition Dataset>
void verifyOne(const std::filesystem::path& dataDirectory)
{
    const auto path = dataDirectory / (std::string{ Dataset::kDataPath } + ".yaml");
    try
    {
        const auto records = Dataset::decode(loadMergedYaml(path.string(), {}));
        std::cout << "verified " << path.string() << " (" << records.size() << " records)\n";
    }
    catch (const std::exception& error)
    {
        throw std::runtime_error(path.string() + ": " + error.what());
    }
}

auto readFile(const std::filesystem::path& path) -> std::string
{
    std::ifstream input(path, std::ios::binary);
    return { std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };
}

// Preserve the file timestamp when generated output is unchanged.
void publishOne(const std::filesystem::path& path, const std::string& content)
{
    if (std::filesystem::exists(path) && readFile(path) == content)
    {
        std::cout << "unchanged " << path.string() << '\n';
        return;
    }

    std::ofstream output(path, std::ios::binary);
    if (!(output << content))
    {
        throw std::runtime_error("cannot write " + path.string());
    }

    std::cout << "wrote " << path.string() << '\n';
}

void verifyData(const std::filesystem::path& dataDirectory)
{
    datasets::Catalog::forEach([&]<class Dataset>(std::type_identity<Dataset>)
                               {
                                   verifyOne<Dataset>(dataDirectory);
                               });
}

void publish(const std::filesystem::path& outputDirectory)
{
    std::filesystem::create_directories(outputDirectory);

    datasets::Catalog::forEach([&]<class Dataset>(std::type_identity<Dataset>)
                               {
                                   const auto path = outputDirectory / (std::string{ Dataset::kDataPath } + ".schema.json");
                                   publishOne(path, makeDatasetSchema<Dataset>());
                               });
}

} // namespace

} // namespace xi::data::schema

int main(int argc, char** argv)
{
    std::filesystem::path outputDirectory{ "data/schemas" };
    std::filesystem::path dataDirectory{ "data" };
    bool                  verify = false;

    for (int i = 1; i < argc; ++i)
    {
        const std::string_view argument{ argv[i] };
        if (argument == "--verify-data")
        {
            verify = true;
        }
        else if (argument == "--output" && i + 1 < argc)
        {
            outputDirectory = argv[++i];
        }
        else if (argument == "--data" && i + 1 < argc)
        {
            dataDirectory = argv[++i];
        }
        else
        {
            std::cerr << "usage: xi_data_schema [--verify-data] [--data DIR] [--output DIR]\n";
            return 2;
        }
    }

    try
    {
        if (verify)
        {
            xi::data::schema::verifyData(dataDirectory);
        }

        xi::data::schema::publish(outputDirectory);
        return 0;
    }
    catch (const std::exception& error)
    {
        std::cerr << "xi_data_schema: " << error.what() << '\n';
        return 1;
    }
}
