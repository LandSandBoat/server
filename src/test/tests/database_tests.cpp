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

#include <common/database.h>
#include <common/database/query_validation.h>

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <cstddef>
#include <limits>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <vector>

namespace
{

template <typename ProjectFn>
concept BulkAcceptsProjection = requires(const std::vector<int>& rows, ProjectFn project) {
    db::executeBulk("", rows, project);
};

using TupleProjection = decltype([](const int value)
                                 {
                                     return std::tuple{ value };
                                 });

using ScalarProjection = decltype([](const int value)
                                  {
                                      return value;
                                  });

static_assert(BulkAcceptsProjection<TupleProjection>);
static_assert(!BulkAcceptsProjection<ScalarProjection>);

template <typename Text>
concept AcceptsQueryText = requires(Text text) { db::preparedStmt(text); };

static_assert(AcceptsQueryText<const char (&)[9]>);
static_assert(AcceptsQueryText<db::Query>);
static_assert(!AcceptsQueryText<const char*>);
static_assert(!AcceptsQueryText<std::string>);
static_assert(!AcceptsQueryText<std::string_view>);

static_assert(db::Query("SHOW TABLES").type() == db::ResultSetType::Select);
static_assert(db::Query("UPDATE t SET a = ?").type() == db::ResultSetType::Update);

// These would fail to compile as a db::Query.
static_assert(db::detail::validateQueryLeadingKeyword("EXPLAIN SELECT 1") == db::ResultSetType::Invalid);
static_assert(!db::detail::validateQueryContent("SELECT 1; SELECT 2"));
static_assert(!db::detail::validateQueryContent("SELECT '{}'"));

static_assert(db::Query("SELECT 1").placeholders() == 0);
static_assert(db::Query("SELECT ?, ?").placeholders() == 2);
static_assert(db::Query("SELECT '?', \"?\", `?`, ?").placeholders() == 1);
static_assert(db::Query("SELECT 'it\\'s ?', ?").placeholders() == 1);

} // namespace

namespace
{

template <typename T>
auto roundTrip(const T value) -> T
{
    const auto rset = db::preparedStmt("SELECT ?", value);
    REQUIRE(rset);
    REQUIRE(rset->next());
    return rset->get<T>(0);
}

} // namespace

TEST_CASE("db::preparedStmt stores bound strings verbatim", "[database]")
{
    // Bound values never need escaping, so escaping one first corrupts it.
    const auto raw = std::string("O'Brien said \"100%\"; C:\\path | done");

    const auto rset = db::preparedStmt("SELECT ?", raw);
    REQUIRE(rset);
    REQUIRE(rset->next());

    CHECK(rset->get<std::string>(0) == raw);
}

TEST_CASE("db::preparedStmt takes a named query", "[database]")
{
    constexpr auto query = db::Query("SELECT ? + 1");

    const auto rset = db::preparedStmt(query, 1);
    REQUIRE(rset);
    REQUIRE(rset->next());

    CHECK(rset->get<int64>(0) == 2);
}

TEST_CASE("db::detail::validateQueryLeadingKeyword", "[database]")
{
    using db::ResultSetType;
    using db::detail::validateQueryLeadingKeyword;

    CHECK(validateQueryLeadingKeyword("SELECT 1") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("select 1") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SHOW TRIGGERS") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("  \n  SELECT 1") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("\tSELECT 1") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SELECT\n1") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SELECT\t*") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SELECT") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SELECT(1)") == ResultSetType::Select);
    CHECK(validateQueryLeadingKeyword("SELECT*FROM t") == ResultSetType::Select);

    CHECK(validateQueryLeadingKeyword("INSERT INTO t VALUES (1)") == ResultSetType::Update);
    CHECK(validateQueryLeadingKeyword("Update t SET a = 1") == ResultSetType::Update);
    CHECK(validateQueryLeadingKeyword("START TRANSACTION") == ResultSetType::Update);
    CHECK(validateQueryLeadingKeyword("ROLLBACK") == ResultSetType::Update);

    CHECK(validateQueryLeadingKeyword("") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword(" \n\t ") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword("SELECTED 1") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword("SELECT1") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword("INSERT_LOG VALUES (1)") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword("(SELECT 1)") == ResultSetType::Invalid);
    CHECK(validateQueryLeadingKeyword("EXPLAIN SELECT 1") == ResultSetType::Invalid);
}

TEST_CASE("db::transaction", "[database]")
{
    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_transaction (id INT) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_transaction"));

    const auto rowCount = []
    {
        const auto rset = db::preparedStmt("SELECT COUNT(*) FROM catch2_transaction");
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset->get<uint64>(0);
    };

    SECTION("commits when the function returns")
    {
        const auto committed = db::transaction(
            []
            {
                db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)");
            });

        CHECK(committed);
        CHECK(rowCount() == 1);
    }

    SECTION("rolls back when the function throws")
    {
        const auto committed = db::transaction(
            []
            {
                db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)");
                throw std::runtime_error("abort");
            });

        CHECK_FALSE(committed);
        CHECK(rowCount() == 0);
    }

    SECTION("rolls back when the function throws something other than std::exception")
    {
        const auto committed = db::transaction(
            []
            {
                db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)");
                throw 42;
            });

        CHECK_FALSE(committed);
        CHECK(rowCount() == 0);
    }

    SECTION("a nested transaction joins the outer one")
    {
        const auto committed = db::transaction(
            []
            {
                db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)");
                db::transaction(
                    []
                    {
                        db::preparedStmt("INSERT INTO catch2_transaction VALUES (2)");
                    });
                throw std::runtime_error("abort after the nested transaction");
            });

        CHECK_FALSE(committed);
        CHECK(rowCount() == 0);
    }

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_transaction"));
}

TEST_CASE("db::preparedStmt binds 64-bit integers without truncating", "[database]")
{
    CHECK(roundTrip(std::numeric_limits<uint64>::max()) == std::numeric_limits<uint64>::max());
    CHECK(roundTrip(std::numeric_limits<int64>::min()) == std::numeric_limits<int64>::min());
    CHECK(roundTrip(std::numeric_limits<int64>::max()) == std::numeric_limits<int64>::max());
    CHECK(roundTrip(std::size_t{ 5'000'000'000 }) == std::size_t{ 5'000'000'000 });
}

TEST_CASE("db::preparedStmt rejects a selected query given the wrong number of arguments", "[database]")
{
    constexpr auto query = db::Query("SELECT ? + ?");

    CHECK_FALSE(db::preparedStmt(db::selected(query), 1));
    CHECK_FALSE(db::preparedStmt(db::selected(query), 1, 2, 3));
    CHECK(db::preparedStmt(db::selected(query), 1, 2));
}

TEST_CASE("db::preparedStmt round-trips edge values", "[database]")
{
    SECTION("integer limits")
    {
        CHECK(roundTrip(std::numeric_limits<int8>::min()) == std::numeric_limits<int8>::min());
        CHECK(roundTrip(std::numeric_limits<uint8>::max()) == std::numeric_limits<uint8>::max());
        CHECK(roundTrip(std::numeric_limits<int16>::min()) == std::numeric_limits<int16>::min());
        CHECK(roundTrip(std::numeric_limits<uint16>::max()) == std::numeric_limits<uint16>::max());
        CHECK(roundTrip(std::numeric_limits<int32>::min()) == std::numeric_limits<int32>::min());
        CHECK(roundTrip(std::numeric_limits<uint32>::max()) == std::numeric_limits<uint32>::max());
    }

    SECTION("bool, float and double")
    {
        CHECK(roundTrip(true));
        CHECK_FALSE(roundTrip(false));
        CHECK(roundTrip(1.5f) == 1.5f);
        CHECK(roundTrip(-2.25) == -2.25);
    }

    SECTION("strings")
    {
        CHECK(roundTrip(std::string()).empty());
        CHECK(roundTrip(std::string(10'000, 'x')) == std::string(10'000, 'x'));
        CHECK(roundTrip(std::string("Windurst \xE2\x98\x86")) == "Windurst \xE2\x98\x86");
        CHECK(roundTrip(std::string("a\0b", 3)) == std::string("a\0b", 3));
    }

    SECTION("a char buffer binds up to its first NUL")
    {
        char name[21] = "Linkshell";

        const auto rset = db::preparedStmt("SELECT ?", name);
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<std::string>(0) == "Linkshell");
    }

    SECTION("enums bind as their underlying type")
    {
        enum class Colour : uint16
        {
            Red = 513,
        };

        CHECK(roundTrip(Colour::Red) == Colour::Red);
    }
}

TEST_CASE("db::ResultSet reads", "[database]")
{
    SECTION("NULL reads as the default value")
    {
        const auto rset = db::preparedStmt("SELECT NULL AS value");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->isNull("value"));
        CHECK(rset->get<uint32>("value") == 0);
        CHECK(rset->get<std::string>("value").empty());
        CHECK(rset->getOrDefault<uint32>("value", 7) == 7);
    }

    SECTION("an unknown column reads as the default value")
    {
        const auto rset = db::preparedStmt("SELECT 1 AS value");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<uint32>("missing") == 0);
    }

    SECTION("reading before next() gives the default value")
    {
        const auto rset = db::preparedStmt("SELECT 5 AS value");
        REQUIRE(rset);

        CHECK(rset->get<uint32>("value") == 0);
    }

    SECTION("an empty result has no rows")
    {
        const auto rset = db::preparedStmt("SELECT 1 FROM DUAL WHERE 1 = 0");
        REQUIRE(rset);

        CHECK(rset->rowsCount() == 0);
        CHECK_FALSE(rset->next());
    }
}

TEST_CASE("db::preparedStmt rejects bad statements", "[database]")
{
    CHECK_FALSE(db::preparedStmt("SELECT * FROM catch2_table_that_does_not_exist"));

    // '%' is the LIKE wildcard, so it must survive validation.
    CHECK(db::preparedStmt("SELECT 'abc' LIKE ?", "a%"));
}

TEST_CASE("db::executeBulk", "[database]")
{
    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_bulk (id INT, amount BIGINT UNSIGNED) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_bulk"));

    const auto rowCount = []
    {
        const auto rset = db::preparedStmt("SELECT COUNT(*) FROM catch2_bulk");
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset->get<uint64>(0);
    };

    SECTION("does nothing for no rows")
    {
        db::executeBulk("INSERT INTO catch2_bulk VALUES (?, ?)", std::vector<int32>{}, [](const int32 id)
                        {
                            return std::tuple{ id, uint64{ 0 } };
                        });

        CHECK(rowCount() == 0);
    }

    SECTION("inserts every row")
    {
        db::executeBulk("INSERT INTO catch2_bulk VALUES (?, ?)", std::vector<int32>{ 1, 2, 3 }, [](const int32 id)
                        {
                            return std::tuple{ id, uint64{ 5'000'000'000 } };
                        });

        CHECK(rowCount() == 3);
    }

    SECTION("throws for string columns")
    {
        CHECK_THROWS(db::executeBulk("INSERT INTO catch2_bulk VALUES (?, ?)", std::vector<int32>{ 1 }, [](const int32 id)
                                     {
                                         return std::tuple{ id, std::string("x") };
                                     }));
    }

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_bulk"));
}

TEST_CASE("db::getTableColumnNames", "[database]")
{
    CHECK(db::getTableColumnNames("catch2_table_that_does_not_exist").empty());

    const auto columns = db::getTableColumnNames("char_points");
    CHECK(std::ranges::find(columns, "charid") != columns.end());
}
