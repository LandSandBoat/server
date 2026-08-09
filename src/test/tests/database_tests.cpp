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

#include <common/database/binding.h>
#include <common/database/blob.h>
#include <common/database/database.h>
#include <common/database/libmariadb/libmariadb_result_set.h>
#include <common/database/query_string.h>
#include <common/database/query_validation.h>
#include <common/database/result_set.h>

#include <common/xi.h>

#include <common/types/fn.h>

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <cstdint>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>

namespace
{

using db::ResultSetType;

//
// Query classification is constexpr: lock the contract at compile time.
//

static_assert(db::detail::validateQueryLeadingKeyword("SELECT * FROM chars") == ResultSetType::Select);
static_assert(db::detail::validateQueryLeadingKeyword("  \n\t select 1") == ResultSetType::Select);
static_assert(db::detail::validateQueryLeadingKeyword("SHOW TRIGGERS") == ResultSetType::Select);
static_assert(db::detail::validateQueryLeadingKeyword("INSERT INTO t VALUES (?)") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("Update t SET x = 1") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("DELETE FROM t") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("REPLACE INTO t VALUES (?)") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("START TRANSACTION") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("COMMIT") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("ROLLBACK") == ResultSetType::Update);
static_assert(db::detail::validateQueryLeadingKeyword("") == ResultSetType::Invalid);
static_assert(db::detail::validateQueryLeadingKeyword("   \n ") == ResultSetType::Invalid);
static_assert(db::detail::validateQueryLeadingKeyword("EXPLAIN SELECT 1") == ResultSetType::Invalid);
static_assert(db::detail::validateQueryLeadingKeyword("SELECTX") == ResultSetType::Invalid);

static_assert(db::detail::validateQueryContent("SELECT name FROM chars WHERE charid = ?"));
static_assert(!db::detail::validateQueryContent("SELECT 1; DROP TABLE chars"));
static_assert(!db::detail::validateQueryContent("SELECT {} FROM chars"));

//
// Placeholder counting backs the compile-time '?' count vs argument count check.
//

static_assert(db::detail::countPlaceholders("SELECT * FROM t") == 0);
static_assert(db::detail::countPlaceholders("... WHERE a = ? AND b = ?") == 2);
static_assert(db::detail::countPlaceholders("... WHERE name = '?'") == 0);         // '?' inside quotes is data
static_assert(db::detail::countPlaceholders("... WHERE a = '\\?' OR b = ?") == 1); // escaped quote, then a real one

enum class TestJob : uint16
{
    Warrior = 1,
    Monk    = 2,
};

struct TestBlob
{
    uint8 a;
    uint8 b;
    uint8 c;
    uint8 tail[5];
};

static_assert(std::is_trivially_copyable_v<TestBlob>);

// A two-row, five-column result set exercising every cell alternative.
//
//   id     name    hp      ratio   data
//   42     "Kupo"  1500    0.5     NULL
//   "77"   NULL    0       2.25    "\x01\x00\x02"
//
auto makeSelectResultSet() -> std::unique_ptr<db::ResultSet>
{
    auto schema   = std::make_shared<db::ColumnSchema>();
    schema->names = { "id", "name", "hp", "ratio", "data" };
    for (std::size_t i = 0; i < schema->names.size(); ++i)
    {
        schema->index[schema->names[i]] = i;
    }

    std::vector<db::LibMariaDBResultSet::Cell> cells;
    cells.emplace_back(int64{ 42 });
    cells.emplace_back(std::string("Kupo"));
    cells.emplace_back(uint64{ 1500 });
    cells.emplace_back(double{ 0.5 });
    cells.emplace_back(std::monostate{});

    cells.emplace_back(std::string("77"));
    cells.emplace_back(std::monostate{});
    cells.emplace_back(uint64{ 0 });
    cells.emplace_back(double{ 2.25 });
    cells.emplace_back(std::string("\x01\x00\x02", 3));

    return std::make_unique<db::LibMariaDBResultSet>("SELECT id, name, hp, ratio, data FROM test", std::move(schema), std::move(cells));
}

// A backend that records the statements it is asked to run, so transaction control flow can be
// checked without a server.
class RecordingDatabase final : public db::Database
{
public:
    auto execute(std::string_view query, const std::vector<db::BoundValue>& /*params*/) -> std::unique_ptr<db::ResultSet> override
    {
        queries.emplace_back(query);
        return std::make_unique<db::LibMariaDBResultSet>(std::size_t{ 1 }, query);
    }

    auto executeBulk(std::string_view query, const std::vector<db::BoundValue>& /*params*/) -> std::unique_ptr<db::ResultSet> override
    {
        queries.emplace_back(query);
        return std::make_unique<db::LibMariaDBResultSet>(std::size_t{ 1 }, query);
    }

    auto getSchema() -> std::string override
    {
        return "test";
    }

    auto getVersion() -> std::string override
    {
        return "test";
    }

    auto getDriverVersion() -> std::string override
    {
        return "test";
    }

    void setInTransaction(bool value) override
    {
        inTransaction_ = value;
    }

    auto isInTransaction() -> bool override
    {
        return inTransaction_;
    }

    auto count(std::string_view query) const -> std::size_t
    {
        return static_cast<std::size_t>(std::ranges::count(queries, query));
    }

    std::vector<std::string> queries;

private:
    bool inTransaction_{ false };
};

TEST_CASE("a nested transaction joins the one already open", "[database]")
{
    RecordingDatabase fake;

    auto* const previous = &db::getDatabase();
    db::setDatabase(&fake);
    const auto restore = xi::finally<Fn<void()>>(
        [previous]() -> void
        {
            db::setDatabase(previous);
        });

    auto innerRan = false;

    const auto committed = db::transaction(
        [&]() -> void
        {
            db::transaction(
                [&]() -> void
                {
                    innerRan = true;
                });
        });

    CHECK(committed);
    CHECK(innerRan);

    // A second START TRANSACTION would have committed the outer one behind its back.
    CHECK(fake.count("START TRANSACTION") == 1);
    CHECK(fake.count("COMMIT") == 1);
    CHECK(fake.count("ROLLBACK") == 0);
}

TEST_CASE("a throw from a nested transaction rolls the outer one back", "[database]")
{
    RecordingDatabase fake;

    auto* const previous = &db::getDatabase();
    db::setDatabase(&fake);
    const auto restore = xi::finally<Fn<void()>>(
        [previous]() -> void
        {
            db::setDatabase(previous);
        });

    const auto committed = db::transaction(
        [&]() -> void
        {
            db::transaction(
                [&]() -> void
                {
                    throw std::runtime_error("inner failed");
                });
        });

    CHECK_FALSE(committed);
    CHECK(fake.count("COMMIT") == 0);
    CHECK(fake.count("ROLLBACK") == 1);
}

TEST_CASE("placeholders builds the IN-list hole text", "[database]")
{
    CHECK(db::placeholders(0) == "");
    CHECK(db::placeholders(1) == "?");
    CHECK(db::placeholders(3) == "?, ?, ?");
}

TEST_CASE("parameter lowering picks the matching BoundValue alternative", "[database]")
{
    const char* cstr = "cstr";

    const auto params = db::detail::lowerBoundValues(
        int8{ -1 },
        uint8{ 2 },
        int16{ -3 },
        uint16{ 4 },
        int32{ -5 },
        uint32{ 6 },
        int64{ -7 },
        uint64{ 8 },
        true,
        1.5f,
        2.25,
        std::string("str"),
        cstr);

    REQUIRE(params.size() == 13);
    CHECK(std::get<int8>(params[0]) == -1);
    CHECK(std::get<uint8>(params[1]) == 2);
    CHECK(std::get<int16>(params[2]) == -3);
    CHECK(std::get<uint16>(params[3]) == 4);
    CHECK(std::get<int32>(params[4]) == -5);
    CHECK(std::get<uint32>(params[5]) == 6);
    CHECK(std::get<int64>(params[6]) == -7);
    CHECK(std::get<uint64>(params[7]) == 8);
    CHECK(std::get<bool>(params[8]) == true);
    CHECK(std::get<float>(params[9]) == 1.5f);
    CHECK(std::get<double>(params[10]) == 2.25);
    CHECK(std::get<std::string>(params[11]) == "str");
    CHECK(std::get<std::string>(params[12]) == "cstr");
}

TEST_CASE("parameter lowering accepts a string_view without a copy at the call site", "[database]")
{
    const auto params = db::detail::lowerBoundValues(std::string_view("kupo"));

    REQUIRE(params.size() == 1);
    CHECK(std::get<std::string>(params[0]) == "kupo");
}

TEST_CASE("QueryString validates a literal and carries its text", "[database]")
{
    // Constructed from a string literal: the leading keyword, forbidden characters, and the
    // placeholder count (one '?' against one bound argument) are all checked at compile time.
    const db::QueryString<uint32> validated("SELECT name FROM chars WHERE charid = ?");
    CHECK(validated.text() == "SELECT name FROM chars WHERE charid = ?");

    // Runtime-built text takes the unchecked path; the layer validates it at prepare time.
    const std::string       dynamic = "SELECT 1";
    const db::QueryString<> runtimeQuery{ std::string_view(dynamic) };
    CHECK(runtimeQuery.text() == "SELECT 1");

    const db::QueryString<> marked{ db::runtime("SELECT 2") };
    CHECK(marked.text() == "SELECT 2");
}

TEST_CASE("parameter lowering decays enums to their underlying type", "[database]")
{
    const auto params = db::detail::lowerBoundValues(TestJob::Monk);

    REQUIRE(params.size() == 1);
    CHECK(std::get<uint16>(params[0]) == 2);
}

TEST_CASE("parameter lowering binds optionals and nullopt as value-or-NULL", "[database]")
{
    const auto params = db::detail::lowerBoundValues(
        std::optional<uint32>{ 42 },
        std::optional<uint32>{},
        std::nullopt,
        std::optional<std::string>{ "midgard" });

    REQUIRE(params.size() == 4);
    CHECK(std::get<uint32>(params[0]) == 42);
    CHECK(std::holds_alternative<std::monostate>(params[1]));
    CHECK(std::holds_alternative<std::monostate>(params[2]));
    CHECK(std::get<std::string>(params[3]) == "midgard");
}

TEST_CASE("parameter lowering expands vectors element-wise, in order", "[database]")
{
    const auto params = db::detail::lowerBoundValues(
        uint32{ 99 },
        std::vector<std::string>{ "ROTZ", "COP" },
        std::vector<uint16>{ 10, 11, 12 });

    REQUIRE(params.size() == 6);
    CHECK(std::get<uint32>(params[0]) == 99);
    CHECK(std::get<std::string>(params[1]) == "ROTZ");
    CHECK(std::get<std::string>(params[2]) == "COP");
    CHECK(std::get<uint16>(params[3]) == 10);
    CHECK(std::get<uint16>(params[4]) == 11);
    CHECK(std::get<uint16>(params[5]) == 12);
}

TEST_CASE("parameter lowering wraps trivially-copyable structs as blobs", "[database]")
{
    auto blob = TestBlob{ 1, 2, 3, {} };

    const auto params = db::detail::lowerBoundValues(blob);

    REQUIRE(params.size() == 1);

    const auto& bound = std::get<db::Blob>(params[0]);
    REQUIRE(bound.bytes.size() == sizeof(TestBlob));
    CHECK(bound.bytes[0] == 1);
    CHECK(bound.bytes[1] == 2);
    CHECK(bound.bytes[2] == 3);
}

TEST_CASE("result set reads cells by key and by index", "[database]")
{
    const auto rset = makeSelectResultSet();

    CHECK(rset->type() == ResultSetType::Select);
    CHECK(rset->rowsCount() == 2);
    CHECK(rset->columnCount() == 5);
    CHECK(rset->columnName(1) == "name");

    REQUIRE(rset->next());
    CHECK(rset->get<uint32>("id") == 42);
    CHECK(rset->get<uint32>(0) == 42);
    CHECK(rset->get<std::string>("name") == "Kupo");
    CHECK(rset->get<uint16>("hp") == 1500);
    CHECK(rset->get<float>("ratio") == 0.5f);
    CHECK(rset->get<TestJob>("hp") == static_cast<TestJob>(1500));
    CHECK(rset->isNull("data"));
    CHECK_FALSE(rset->isNull("id"));

    REQUIRE(rset->next());
    // Text cells coerce to numbers, and numeric cells to text.
    CHECK(rset->get<uint32>("id") == 77);
    CHECK(rset->get<std::string>("id") == "77");
    CHECK(rset->get<double>("ratio") == 2.25);

    CHECK_FALSE(rset->next());
}

TEST_CASE("result set distinguishes NULL, absent columns, and fallbacks", "[database]")
{
    const auto rset = makeSelectResultSet();

    REQUIRE(rset->next());

    // Unknown columns read as empty/NULL (and log an error).
    CHECK(rset->get<uint32>("no_such_column") == 0);
    CHECK(rset->isNull("no_such_column"));
    CHECK(rset->getOrDefault<uint32>("no_such_column", 7) == 7);
    CHECK_FALSE(rset->tryGet<uint32>("no_such_column").has_value());

    // NULL cells: get() flattens to T{}, getOrDefault() falls back, tryGet() is disengaged.
    CHECK(rset->get<uint32>("data") == 0);
    CHECK(rset->getOrDefault<uint32>("data", 7) == 7);
    CHECK_FALSE(rset->tryGet<uint32>("data").has_value());

    // Present cells: getOrDefault() ignores the fallback, tryGet() is engaged.
    CHECK(rset->getOrDefault<uint32>("id", 7) == 42);

    const auto id = rset->tryGet<uint32>("id");
    REQUIRE(id.has_value());
    CHECK(*id == 42);

    const auto name = rset->tryGet<std::string>(1);
    REQUIRE(name.has_value());
    CHECK(*name == "Kupo");
}

TEST_CASE("result set preserves blob bytes, including embedded NULs", "[database]")
{
    const auto rset = makeSelectResultSet();

    REQUIRE(rset->next());
    REQUIRE(rset->next());

    const auto bytes = rset->getBlobBytes("data");
    REQUIRE(bytes.size() == 3);
    CHECK(bytes[0] == '\x01');
    CHECK(bytes[1] == '\x00');
    CHECK(bytes[2] == '\x02');

    // extractFromBlob zero-fills the tail the blob does not cover.
    auto destination = TestBlob{ 9, 9, 9, { 9, 9, 9, 9, 9 } };
    db::extractFromBlob(rset, "data", destination);
    CHECK(destination.a == 1);
    CHECK(destination.b == 0);
    CHECK(destination.c == 2);
    for (const auto tailByte : destination.tail)
    {
        CHECK(tailByte == 0);
    }
}

TEST_CASE("db::rows iterates SELECT results and is empty otherwise", "[database]")
{
    auto rset = makeSelectResultSet();

    std::vector<uint32> ids;
    for (const auto& row : db::rows(rset))
    {
        ids.push_back(row.get<uint32>("id"));
    }
    CHECK(ids == std::vector<uint32>{ 42, 77 });

    const std::unique_ptr<db::ResultSet> nullRset;
    for ([[maybe_unused]] const auto& row : db::rows(nullRset))
    {
        FAIL("a null result set must yield an empty range");
    }

    const std::unique_ptr<db::ResultSet> updateRset = std::make_unique<db::LibMariaDBResultSet>(std::size_t{ 5 }, "UPDATE test SET x = 1");
    for ([[maybe_unused]] const auto& row : db::rows(updateRset))
    {
        FAIL("an UPDATE result must yield an empty range");
    }
}

TEST_CASE("update results report rows affected", "[database]")
{
    const auto rset = std::make_unique<db::LibMariaDBResultSet>(std::size_t{ 5 }, "UPDATE test SET x = 1");

    CHECK(rset->type() == ResultSetType::Update);
    CHECK(rset->rowsAffected() == 5);
}

} // namespace
