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

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_transaction"));
}
