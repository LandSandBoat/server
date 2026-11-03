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

#include "in_memory_sink.h"

#include <common/database.h>
#include <common/database/blob.h>
#include <common/database/query_validation.h>
#include <common/scheduler/scheduler.h>
#include <common/settings.h>
#include <common/xi.h>

#include <catch2/catch_test_macros.hpp>
#include <spdlog/spdlog.h>

#include <algorithm>
#include <array>
#include <chrono>
#include <cstddef>
#include <cstring>
#include <limits>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
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

using MixedNumberProjection = decltype([](const int value)
                                       {
                                           return std::tuple{ value, true, 1.5 };
                                       });

using StringProjection = decltype([](const int value)
                                  {
                                      return std::tuple{ value, std::string("x") };
                                  });

static_assert(BulkAcceptsProjection<TupleProjection>);
static_assert(BulkAcceptsProjection<MixedNumberProjection>);
static_assert(!BulkAcceptsProjection<ScalarProjection>);
static_assert(!BulkAcceptsProjection<StringProjection>, "Bulk binding takes numbers, bools and enums only");

// A requires-expression doesn't evaluate consteval calls, so it can't see a wrong placeholder count or a
// non-constant query rejected. These assert the values those checks compare instead.
static_assert(db::detail::rowWidth<TupleProjection, int>() == 1);
static_assert(db::detail::rowWidth<ScalarProjection, int>() == 0);

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

template <typename T>
auto roundTrip(const T& value) -> T
{
    const auto rset = db::preparedStmt("SELECT ?", value);
    REQUIRE(rset);
    REQUIRE(rset->next());
    return rset->template get<T>(0);
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

TEST_CASE("db::preparedStmt binds a char array up to its first zero byte", "[database]")
{
    // Packet buffers fill the whole array, so there may be no terminator to stop at.
    const char full[4]   = { 'a', 'b', 'c', 'd' };
    const char padded[8] = { 'a', 'b', '\0', 'd' };

    const auto rset = db::preparedStmt("SELECT ? AS whole, ? AS padded", full, padded);
    REQUIRE(rset);
    REQUIRE(rset->next());

    CHECK(rset->get<std::string>("whole") == "abcd");
    CHECK(rset->get<std::string>("padded") == "ab");
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
                CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)"));
            });

        CHECK(committed);
        CHECK(rowCount() == 1);
    }

    SECTION("rolls back when the function throws")
    {
        const auto committed = db::transaction(
            []
            {
                CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)"));
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
                CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)"));
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
                CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)"));
                db::transaction(
                    []
                    {
                        CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (2)"));
                    });
                throw std::runtime_error("abort after the nested transaction");
            });

        CHECK_FALSE(committed);
        CHECK(rowCount() == 0);
    }

    SECTION("a throw inside a nested transaction rolls back the outer one")
    {
        const auto committed = db::transaction(
            []
            {
                CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (1)"));
                db::transaction(
                    []
                    {
                        CHECK(db::preparedStmt("INSERT INTO catch2_transaction VALUES (2)"));
                        throw std::runtime_error("abort inside the nested transaction");
                    });
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
                            return std::tuple{ id, uint64{ 5'000'000'000 } * static_cast<uint64>(id) };
                        });

        CHECK(rowCount() == 3);

        const auto rset = db::preparedStmt("SELECT CAST(SUM(amount) AS UNSIGNED) AS total FROM catch2_bulk");
        REQUIRE(rset);
        REQUIRE(rset->next());
        CHECK(rset->get<uint64>("total") == 30'000'000'000);
    }

    SECTION("a row that fails throws, and saves none of the rows")
    {
        // It throws so an enclosing transaction rolls back too.
        CHECK_THROWS(db::executeBulk(
            "INSERT INTO catch2_bulk VALUES (?, ?)",
            std::vector<int64>{ 1, 2, 3'000'000'000 },
            [](const int64 id)
            {
                return std::tuple{ id, uint64{ 0 } };
            }));

        CHECK(rowCount() == 0);
    }

    SECTION("a failing row inside a transaction rolls back the whole transaction")
    {
        const auto committed = db::transaction(
            []
            {
                CHECK(db::preparedStmt("INSERT INTO catch2_bulk VALUES (?, ?)", 9, uint64{ 0 }));
                db::executeBulk(
                    "INSERT INTO catch2_bulk VALUES (?, ?)",
                    std::vector<int64>{ 1, 3'000'000'000 },
                    [](const int64 id)
                    {
                        return std::tuple{ id, uint64{ 0 } };
                    });
            });

        CHECK_FALSE(committed);
        CHECK(rowCount() == 0);
    }

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_bulk"));
}

TEST_CASE("db::getTableColumnNames", "[database]")
{
    CHECK(db::getTableColumnNames("catch2_table_that_does_not_exist").empty());

    const auto columns = db::getTableColumnNames("char_points");
    CHECK(std::ranges::find(columns, "charid") != columns.end());
}

namespace
{

// Shaped like the small fixed records stored in blob columns, with no padding bytes.
struct BlobRecord
{
    uint8  kind;
    uint8  flags;
    uint16 count;
    uint32 id;
};

static_assert(sizeof(BlobRecord) == 8);

template <typename Value>
concept Binds = requires(Value value) { db::preparedStmt("SELECT ?", value); };

enum class BindColour : uint16
{
    Red = 513,
};

static_assert(Binds<int8> && Binds<uint8> && Binds<int16> && Binds<uint16> && Binds<int32> && Binds<uint32>);
static_assert(Binds<int64> && Binds<uint64> && Binds<std::size_t> && Binds<bool> && Binds<float> && Binds<double>);
static_assert(Binds<std::string> && Binds<const char*>);
static_assert(Binds<BindColour>, "An enum binds as its underlying type");
static_assert(Binds<char (&)[21]>, "A char buffer binds as text up to its first zero byte");
static_assert(Binds<uint8 (&)[24]> && Binds<std::array<uint16, 3>&> && Binds<BlobRecord&>, "Trivially copyable values bind as blobs");
static_assert(Binds<const BlobRecord&>, "A blob binds from a const value");
static_assert(!Binds<uint8*>, "A pointer would bind its own address");
static_assert(!Binds<std::vector<int>>, "Only trivially copyable values have fixed bytes");
static_assert(!Binds<std::string_view>, "Bind a std::string instead");
static_assert(!Binds<char>, "A plain char is neither int8 nor uint8");
static_assert(Binds<Maybe<int32>> && Binds<Maybe<std::string>>, "A Maybe binds its value, or NULL when empty");
static_assert(Binds<std::nullptr_t>, "nullptr binds NULL");
static_assert(!Binds<Maybe<std::vector<int>>>, "A Maybe binds only what its value type binds");

} // namespace

TEST_CASE("db blob columns", "[database]")
{
    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_blob (id INT, data BLOB) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_blob"));

    const auto store = [](const int32 id, const auto& value)
    {
        REQUIRE(db::preparedStmt("INSERT INTO catch2_blob VALUES (?, ?)", id, value));
    };

    const auto load = [](const int32 id)
    {
        auto rset = db::preparedStmt("SELECT data FROM catch2_blob WHERE id = ?", id);
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset;
    };

    SECTION("a struct round-trips byte for byte")
    {
        auto record = BlobRecord{ .kind = 7, .flags = 0, .count = 513, .id = 0xDEADBEEF };
        store(1, record);

        const auto rset   = load(1);
        const auto loaded = rset->get<BlobRecord>("data");

        CHECK(rset->getBlobBytes("data").size() == sizeof(BlobRecord));
        CHECK(loaded.kind == 7);
        CHECK(loaded.flags == 0);
        CHECK(loaded.count == 513);
        CHECK(loaded.id == 0xDEADBEEF);
    }

    SECTION("a byte array keeps zero, quote, backslash and high bytes")
    {
        uint8 extra[24]{};
        extra[0]  = 0x27;
        extra[1]  = 0x5C;
        extra[2]  = 0x00;
        extra[3]  = 0xFF;
        extra[4]  = 0x25;
        extra[23] = 0x01;
        store(2, extra);

        const auto rset = load(2);

        uint8 loaded[24]{};
        db::extractFromBlob(rset, "data", loaded);

        CHECK(rset->getBlobBytes("data").size() == sizeof(extra));
        CHECK(std::ranges::equal(extra, loaded));
    }

    SECTION("a std::array binds as a blob")
    {
        auto values = std::array<uint16, 3>{ 1, 513, 65535 };
        store(3, values);

        CHECK(load(3)->get<std::array<uint16, 3>>("data") == values);
    }

    SECTION("a shorter blob fills a prefix and zeroes the rest")
    {
        uint8 prefix[2] = { 7, 1 };
        store(4, prefix);

        auto record = BlobRecord{ .kind = 9, .flags = 9, .count = 9, .id = 9 };
        db::extractFromBlob(load(4), "data", record);

        CHECK(record.kind == 7);
        CHECK(record.flags == 1);
        CHECK(record.count == 0);
        CHECK(record.id == 0);
    }

    SECTION("a longer blob is cut to the destination's size")
    {
        auto record = BlobRecord{ .kind = 7, .flags = 1, .count = 513, .id = 0xDEADBEEF };
        store(5, record);

        auto head = uint32{ 0 };
        db::extractFromBlob(load(5), "data", head);

        auto expected = uint32{ 0 };
        std::memcpy(&expected, &record, sizeof(expected));
        CHECK(head == expected);
    }

    SECTION("NULL leaves extractFromBlob's destination alone, and get gives the default")
    {
        // A character created by the login server has NULL blobs until the map server fills them in.
        REQUIRE(db::preparedStmt("INSERT INTO catch2_blob VALUES (?, NULL)", 6));

        auto record = BlobRecord{ .kind = 9, .flags = 9, .count = 9, .id = 9 };
        db::extractFromBlob(load(6), "data", record);

        CHECK(record.kind == 9);
        CHECK(record.id == 9);

        const auto loaded = load(6)->get<BlobRecord>("data");
        CHECK(loaded.kind == 0);
        CHECK(loaded.id == 0);
    }

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_blob"));
}

TEST_CASE("db::BlobWrapper copies its source", "[database]")
{
    uint8 source[4] = { 1, 2, 3, 4 };

    const auto wrapper = db::BlobWrapper::create(source);
    source[0]          = 9;

    REQUIRE(wrapper->size == sizeof(source));
    CHECK(wrapper->data[0] == 1);
    CHECK(wrapper->data[3] == 4);
}

TEST_CASE("db::ResultSet conversions", "[database]")
{
    const auto row = [](auto rset)
    {
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset;
    };

    SECTION("decimals and datetimes come back as text")
    {
        const auto rset = row(db::preparedStmt("SELECT CAST(1.5 AS DECIMAL(3, 1)) AS amount, CAST('2026-10-25 12:00:00' AS DATETIME) AS stamp"));

        CHECK(rset->get<std::string>("amount") == "1.5");
        CHECK(rset->get<double>("amount") == 1.5);
        CHECK(rset->get<uint32>("amount") == 1);
        CHECK(rset->get<std::string>("stamp") == "2026-10-25 12:00:00");
    }

    SECTION("bool is any nonzero number, and text only counts as a number")
    {
        const auto rset = row(db::preparedStmt("SELECT 2 AS two, 'true' AS word, '1' AS digit"));

        CHECK(rset->get<bool>("two"));
        CHECK_FALSE(rset->get<bool>("word"));
        CHECK(rset->get<bool>("digit"));
    }

    SECTION("a floating point column read as text has six decimals")
    {
        CHECK(row(db::preparedStmt("SELECT CAST(1.5 AS DOUBLE) AS value"))->get<std::string>("value") == "1.500000");
    }

    SECTION("text read as a number parses its leading digits")
    {
        CHECK(row(db::preparedStmt("SELECT '12abc' AS value"))->get<uint32>("value") == 12);
        CHECK(row(db::preparedStmt("SELECT 'abc' AS value"))->get<uint32>("value") == 0);
    }
}

TEST_CASE("db::ResultSet columns and rows", "[database]")
{
    SECTION("get by index is zero-based")
    {
        const auto rset = db::preparedStmt("SELECT 7 AS first, 8 AS second");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->columnCount() == 2);
        CHECK(rset->columnName(0) == "first");
        CHECK(rset->columnName(2).empty());
        CHECK(rset->get<uint32>(0) == 7);
        CHECK(rset->get<uint32>(1) == 8);
    }

    SECTION("a repeated column name reads the last column, even by index")
    {
        const auto rset = db::preparedStmt("SELECT 1 AS value, 2 AS value");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<uint32>("value") == 2);
        CHECK(rset->get<uint32>(0) == 2);
    }

    SECTION("a table-qualified column is named without its table")
    {
        const auto rset = db::preparedStmt("SELECT t.value FROM (SELECT 3 AS value) AS t");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<uint32>("value") == 3);
    }

    SECTION("next() stays false past the end, and reads there give the default")
    {
        const auto rset = db::preparedStmt("SELECT 5 AS value");
        REQUIRE(rset);

        CHECK(rset->next());
        CHECK_FALSE(rset->next());
        CHECK_FALSE(rset->next());
        CHECK(rset->get<uint32>("value") == 0);
    }

    SECTION("asking a statement for the other kind of count gives 0")
    {
        const auto select = db::preparedStmt("SELECT 1");
        const auto update = db::preparedStmt("SET @catch2_unused = 1");
        REQUIRE(select);
        REQUIRE(update);

        CHECK(select->rowsAffected() == 0);
        CHECK(update->rowsCount() == 0);
    }

    SECTION("a blob read as text keeps its embedded zero bytes")
    {
        const auto rset = db::preparedStmt("SELECT UNHEX('610062') AS value");
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<std::string>("value").size() == 3);
        CHECK(rset->getBlobBytes("value").size() == 3);
    }
}

TEST_CASE("db rowsAffected counts changed rows, not matched rows", "[database]")
{
    // The connection doesn't set CLIENT_FOUND_ROWS, so an UPDATE that writes the stored value reports 0.
    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_affected (id INT PRIMARY KEY, value INT) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_affected"));

    const auto affected = [](auto rset)
    {
        REQUIRE(rset);
        return rset->rowsAffected();
    };

    CHECK(affected(db::preparedStmt("INSERT INTO catch2_affected VALUES (?, ?)", 1, 10)) == 1);
    CHECK(affected(db::preparedStmt("UPDATE catch2_affected SET value = ? WHERE id = ?", 10, 1)) == 0);
    CHECK(affected(db::preparedStmt("UPDATE catch2_affected SET value = ? WHERE id = ?", 11, 1)) == 1);
    CHECK(affected(db::preparedStmt("UPDATE catch2_affected SET value = ? WHERE id = ?", 11, 2)) == 0);

    // An upsert reports 1 for an insert, 2 for an update and 0 when nothing changed.
    CHECK(affected(db::preparedStmt("INSERT INTO catch2_affected VALUES (?, ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", 2, 20)) == 1);
    CHECK(affected(db::preparedStmt("INSERT INTO catch2_affected VALUES (?, ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", 2, 21)) == 2);
    CHECK(affected(db::preparedStmt("INSERT INTO catch2_affected VALUES (?, ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", 2, 21)) == 0);

    // REPLACE deletes then inserts.
    CHECK(affected(db::preparedStmt("REPLACE INTO catch2_affected VALUES (?, ?)", 2, 22)) == 2);

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_affected"));
}

TEST_CASE("db string comparison", "[database]")
{
    SECTION("an empty string binds as '' rather than NULL")
    {
        const auto rset = db::preparedStmt("SELECT ? IS NULL AS isNull, ? = '' AS isEmpty", std::string(), std::string());
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK_FALSE(rset->get<bool>("isNull"));
        CHECK(rset->get<bool>("isEmpty"));
    }

    SECTION("a character name column ignores case and trailing spaces")
    {
        // Name lookups take client text, so "zach " finds the character named "Zach".
        REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE catch2_names AS SELECT charname AS name FROM chars LIMIT 0"));
        REQUIRE(db::preparedStmt("INSERT INTO catch2_names VALUES (?)", std::string("Zach")));

        const auto rset = db::preparedStmt("SELECT COUNT(*) AS matches FROM catch2_names WHERE name = ?", std::string("zach "));
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->get<uint32>("matches") == 1);

        REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_names"));
    }
}

TEST_CASE("db connections belong to one thread", "[database]")
{
    // Every thread gets its own connection, so temporary tables, transactions and LAST_INSERT_ID() don't cross threads.
    auto scheduler = Scheduler(1);

    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_thread (id INT AUTO_INCREMENT PRIMARY KEY, value INT) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("INSERT INTO catch2_thread (value) VALUES (?)", 1));

    const auto mainInsertId = []
    {
        const auto rset = db::preparedStmt("SELECT LAST_INSERT_ID() AS id");
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset->get<uint64>("id");
    }();
    CHECK(mainInsertId > 0);

    const auto workerSeesTable = scheduler.blockOnMainThread(scheduler.spawnOnWorkerThread(
        []
        {
            return db::preparedStmt("SELECT COUNT(*) FROM catch2_thread") != nullptr;
        }));
    CHECK_FALSE(workerSeesTable);

    const auto workerInsertId = scheduler.blockOnMainThread(scheduler.spawnOnWorkerThread(
        []
        {
            const auto rset = db::preparedStmt("SELECT LAST_INSERT_ID() AS id");
            if (!rset || !rset->next())
            {
                return std::numeric_limits<uint64>::max();
            }

            return rset->get<uint64>("id");
        }));
    CHECK(workerInsertId == 0);

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_thread"));
}

TEST_CASE("db::clearStatementCache", "[database]")
{
    CHECK(db::preparedStmt("SELECT 1"));

    db::clearStatementCache();

    CHECK(db::preparedStmt("SELECT 1"));
}

TEST_CASE("db binds NULL", "[database]")
{
    const auto isNull = [](auto&& value)
    {
        const auto rset = db::preparedStmt("SELECT ? IS NULL AS isNull", std::forward<decltype(value)>(value));
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset->template get<bool>("isNull");
    };

    SECTION("an empty Maybe binds NULL, a full one binds its value")
    {
        CHECK(isNull(Maybe<int32>()));
        CHECK_FALSE(isNull(Maybe<int32>(5)));

        const auto rset = db::preparedStmt("SELECT ? AS value", Maybe<uint32>(7));
        REQUIRE(rset);
        REQUIRE(rset->next());
        CHECK(rset->get<uint32>("value") == 7);
    }

    SECTION("nullptr and a null char pointer bind NULL")
    {
        const char* missing = nullptr;

        CHECK(isNull(nullptr));
        CHECK(isNull(missing));
    }

    SECTION("a NULL stored in a column reads back as NULL")
    {
        REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_nulls (id INT, value INT) ENGINE=InnoDB"));
        REQUIRE(db::preparedStmt("DELETE FROM catch2_nulls"));
        REQUIRE(db::preparedStmt("INSERT INTO catch2_nulls VALUES (?, ?)", 1, Maybe<int32>()));

        const auto rset = db::preparedStmt("SELECT value FROM catch2_nulls WHERE id = ?", 1);
        REQUIRE(rset);
        REQUIRE(rset->next());

        CHECK(rset->isNull("value"));
        CHECK(rset->getOrDefault<int32>("value", -1) == -1);

        REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_nulls"));
    }
}

TEST_CASE("db::ResultSet warns when a read and the schema disagree", "[database]")
{
    const auto sink     = std::make_shared<InMemorySink>();
    const auto previous = spdlog::get("warn");
    REQUIRE(previous);

    // Catch2 runs before the harness captures the loggers, so "warn" is still async here.
    spdlog::drop("warn");
    spdlog::register_logger(std::make_shared<spdlog::logger>("warn", sink));
    logging::RefreshLoggerCache();

    const auto restore = xi::finally(
        [&]
        {
            spdlog::drop("warn");
            spdlog::register_logger(previous);
            logging::RefreshLoggerCache();
        });

    const auto warned = [&](const std::string_view text)
    {
        return std::ranges::any_of(
            sink->logs(),
            [&](const std::string& line)
            {
                return line.contains(text);
            });
    };

    const auto row = [](auto rset)
    {
        REQUIRE(rset);
        REQUIRE(rset->next());
        return rset;
    };

    // Each section uses its own query, because a mismatch only warns the first time.
    SECTION("a value too wide for its type still wraps, with a warning")
    {
        CHECK(row(db::preparedStmt("SELECT 300 AS too_wide"))->get<uint8>("too_wide") == 44);
        CHECK(warned("too_wide holds 300"));
    }

    SECTION("a negative value read as unsigned wraps, and the warning shows the stored value")
    {
        CHECK(row(db::preparedStmt("SELECT -1 AS negative"))->get<uint32>("negative") == std::numeric_limits<uint32>::max());
        CHECK(warned("negative holds -1"));
    }

    SECTION("a value that fits doesn't warn")
    {
        CHECK(row(db::preparedStmt("SELECT 200 AS fits"))->get<uint8>("fits") == 200);
        CHECK_FALSE(warned("doesn't fit"));
    }

    SECTION("a column that doesn't exist still reads as the default, with a warning")
    {
        CHECK(row(db::preparedStmt("SELECT 1 AS present"))->get<uint32>("absent") == 0);
        CHECK(warned("no column named absent"));
    }

    SECTION("getOrDefault on a column that doesn't exist returns the default, with a warning")
    {
        CHECK(row(db::preparedStmt("SELECT 2 AS present"))->getOrDefault<uint32>("absent", 7) == 7);
        CHECK(warned("no column named absent"));
    }

    SECTION("an index past the last column reads as the default, with a warning")
    {
        CHECK(row(db::preparedStmt("SELECT 3 AS present"))->get<uint32>(1) == 0);
        CHECK(warned("no column named"));
    }

    SECTION("a mismatch warns once, not once per row")
    {
        const auto rset = db::preparedStmt("SELECT 300 AS repeated UNION ALL SELECT 301");
        REQUIRE(rset);
        while (rset->next())
        {
            rset->get<uint8>("repeated");
        }

        CHECK(std::ranges::count_if(
                  sink->logs(),
                  [](const std::string& line)
                  {
                      return line.contains("repeated holds");
                  }) == 1);
    }
}

TEST_CASE("db rejects out-of-range writes", "[database]")
{
    REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_strict (id INT, value TINYINT UNSIGNED) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_strict"));

    CHECK(db::preparedStmt("INSERT INTO catch2_strict VALUES (?, ?)", 1, 255));
    CHECK_FALSE(db::preparedStmt("INSERT INTO catch2_strict VALUES (?, ?)", 2, 300));
    CHECK_FALSE(db::preparedStmt("INSERT INTO catch2_strict VALUES (?, ?)", 3, -1));

    const auto rset = db::preparedStmt("SELECT COUNT(*) AS count FROM catch2_strict");
    REQUIRE(rset);
    REQUIRE(rset->next());
    CHECK(rset->get<uint32>("count") == 1);

    REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_strict"));
}

TEST_CASE("db makes every session strict", "[database]")
{
    const auto global = db::preparedStmt("SELECT @@GLOBAL.sql_mode AS mode");
    REQUIRE(global);
    REQUIRE(global->next());
    if (global->get<std::string>("mode").contains("STRICT_TRANS_TABLES"))
    {
        SKIP("The server is strict already, so a strict session proves nothing");
    }

    const auto session = db::preparedStmt("SELECT @@SESSION.sql_mode AS mode");
    REQUIRE(session);
    REQUIRE(session->next());
    CHECK(session->get<std::string>("mode").contains("STRICT_TRANS_TABLES"));
}

TEST_CASE("db reconnects after the server drops an idle connection", "[database]")
{
    if (settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT") == 0)
    {
        SKIP("Reconnecting needs network.SQL_QUERY_RETRY_COUNT above 0");
    }

    const auto restore = xi::finally(
        []
        {
            db::preparedStmt("SET SESSION sql_mode = CONCAT_WS(',', @@GLOBAL.sql_mode, 'STRICT_TRANS_TABLES')");
            db::preparedStmt("SET SESSION wait_timeout = @@GLOBAL.wait_timeout");
        });

    REQUIRE(db::preparedStmt("SET SESSION sql_mode = ''"));
    REQUIRE(db::preparedStmt("SET SESSION wait_timeout = 1"));

    // The server drops the idle connection, so the next query has to reconnect.
    std::this_thread::sleep_for(std::chrono::seconds(3));

    const auto rset = db::preparedStmt("SELECT @@SESSION.sql_mode AS mode, @@SESSION.wait_timeout AS timeout");
    REQUIRE(rset);
    REQUIRE(rset->next());

    CHECK(rset->get<uint32>("timeout") != 1);
    CHECK(rset->get<std::string>("mode").contains("STRICT_TRANS_TABLES"));
}

TEST_CASE("db round-trips utf8mb4 text", "[database]")
{
    // "ヴァナ" and a chick emoji, which needs four bytes.
    const auto text = std::string("\xE3\x83\xB4\xE3\x82\xA1\xE3\x83\x8A \xF0\x9F\x90\xA4");

    SECTION("bound and selected")
    {
        const auto rset = db::preparedStmt("SELECT ? AS value", text);
        REQUIRE(rset);
        REQUIRE(rset->next());
        CHECK(rset->get<std::string>("value") == text);
    }

    SECTION("stored in a utf8mb4 column")
    {
        REQUIRE(db::preparedStmt("CREATE TEMPORARY TABLE IF NOT EXISTS catch2_text (value VARCHAR(32)) CHARACTER SET utf8mb4 ENGINE=InnoDB"));
        REQUIRE(db::preparedStmt("DELETE FROM catch2_text"));
        REQUIRE(db::preparedStmt("INSERT INTO catch2_text VALUES (?)", text));

        const auto rset = db::preparedStmt("SELECT value, CHAR_LENGTH(value) AS length FROM catch2_text");
        REQUIRE(rset);
        REQUIRE(rset->next());
        CHECK(rset->get<std::string>("value") == text);
        CHECK(rset->get<uint32>("length") == 5);

        REQUIRE(db::preparedStmt("DROP TEMPORARY TABLE catch2_text"));
    }
}

TEST_CASE("db doesn't retry a statement when the connection drops mid-transaction", "[database]")
{
    if (settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT") == 0)
    {
        SKIP("Reconnecting needs network.SQL_QUERY_RETRY_COUNT above 0");
    }

    // A dropped connection loses temporary tables, so this one has to be real.
    REQUIRE(db::preparedStmt("CREATE TABLE IF NOT EXISTS catch2_dropped (id INT) ENGINE=InnoDB"));
    REQUIRE(db::preparedStmt("DELETE FROM catch2_dropped"));
    const auto dropTable = xi::finally(
        []
        {
            db::preparedStmt("DROP TABLE IF EXISTS catch2_dropped");
        });

    const auto committed = db::transaction(
        []
        {
            CHECK(db::preparedStmt("INSERT INTO catch2_dropped VALUES (1)"));
            CHECK(db::preparedStmt("SET SESSION wait_timeout = 1"));
            std::this_thread::sleep_for(std::chrono::seconds(3));

            // A retry would run on a fresh connection in autocommit and save this row alone.
            CHECK_FALSE(db::preparedStmt("INSERT INTO catch2_dropped VALUES (2)"));
        });

    CHECK_FALSE(committed);

    const auto rset = db::preparedStmt("SELECT COUNT(*) AS count FROM catch2_dropped");
    REQUIRE(rset);
    REQUIRE(rset->next());
    CHECK(rset->get<uint32>("count") == 0);
}
