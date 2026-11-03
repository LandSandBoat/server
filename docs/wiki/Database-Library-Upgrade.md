**TLDR:**

>- Retire the Windows 32-bit build.
>- Updated the existing `mariadb-connector-c` library.
>- Introduce the `mariadb-connector-cpp` library, which wraps the `mariadb-connector-cpp` with better usage patterns.
>- Add an API on top of `mariadb-connector-cpp` that can be used alongside our current SQL usage.
>- All instances of `sql` global object are replaced with `_sql` because of clashing symbols in the new library. These have since been replaced with the `db` namespace.
>- The new API provides:
>    - Thread-safe usage.
>    - Protection from clobbering your results by interleaving queries.
>    - Option to extract column results of queries by column name rather than by index.
>    - Additional safety through use of prepared statements.
>    - Equivalent-or-better performance.

## Introduction

This page records the original change. The `db::` layer has since moved back to `mariadb-connector-c`. The Usage section describes it as it is now.

## The PR

<https://github.com/LandSandBoat/server/pull/4601>

## What does this mean for my server?

As a player or an operator; nothing. This is primarily a change to help core developers.

### Safety & Developer Quality of Life

Currently, it's very easy to trip yourself up while using the existing code built on top of `mariadb-connector-c`. If you have more than one query in flight on a single connection, you'll clobber the data of your first query. In addition to being very careful, we have had to build many checks and warnings on top of the connector to make it safer an easier to use.

If you have many columns of data to pull from the results of your query, you've previously had to keep them in order and index into the results. If you needed to add or remove columns, you'd have to update all of your indexes. Quite fragile, and this has been the cause of more than a couple of bugs over the last few years.

The new `mariadb-connector-cpp` library fixes both of these issues and provides other goodies for developers. Your query results are stored away into a `Result Set` object, which is safe from clobbering if you want to do other things while you iterate your results. You can now ask your `Result Set` for results by name, rather than index - making it a lot more robust.

It also introduces [Prepared Statements](https://en.wikipedia.org/wiki/Prepared_statement); which boosts efficiency of calling queries by not having to recompile each query from a string on every call, and adds an additional layer of protection for converted queries from [SQL injection](https://en.wikipedia.org/wiki/SQL_injection) attacks.

## Usage

`rset` is a result set. It holds the rows, so other queries can run while you read it.

### `db::preparedStmt`

Every query is a prepared statement. Statements are prepared on first use and cached per thread.

The query must be a string literal or a `constexpr db::Query`. It's checked when it compiles: it must start with a known keyword such as `SELECT` or `UPDATE`, it can't contain `;` or `{}`, and it must have one `?` per argument. Values are always bound to a `?`, never formatted into the text.

```cpp
// Run a query and ignore the result
db::preparedStmt("UPDATE char_stats SET zoning = 0 WHERE charid = ?", PChar->id);

// Check that it ran
if (!db::preparedStmt("UPDATE char_points SET daily_tally = ? WHERE charid = ?", tally, PChar->id))
{
    ShowError("Failed to update daily tally points");
}

// Read one row
const auto rset = db::preparedStmt("SELECT itemid FROM char_inventory WHERE charid = ? LIMIT 1", PChar->id);
if (rset && rset->next())
{
    const auto itemId = rset->get<uint16>("itemid");
}

// Read every row
const auto rset = db::preparedStmt("SELECT itemid FROM char_inventory WHERE charid = ?", PChar->id);
while (rset && rset->next())
{
    const auto itemId = rset->get<uint16>("itemid");
}

// Name a query with constexpr, and start a long one on its own line
constexpr auto query = db::Query(
    "SELECT set_blue_spells FROM chars "
    "WHERE charid = ? LIMIT 1");
const auto rset = db::preparedStmt(query, PChar->id);
```

A query picked at runtime, such as one of several from a table, goes through `db::selected(query)`. Its argument count is then checked when it runs, and a mismatch logs an error and returns `nullptr`.

### Binding values

- Integers, bools, enums, floats and strings bind as you'd expect. 64-bit integers bind as 64-bit.
- An empty `Maybe` or `nullptr` binds `NULL`.
- A trivially copyable struct or array binds as a blob: `db::preparedStmt("UPDATE chars SET set_blue_spells = ? WHERE charid = ?", PChar->m_SetBlueSpells, PChar->id)`.
- Read a blob back with `rset->get<std::array<uint8, 20>>("set_blue_spells")` or `db::extractFromBlob(rset, "set_blue_spells", PChar->m_SetBlueSpells)`.

### Reading values

`rset->get<T>("column")` reads a column by name. It logs a warning when an integer value doesn't fit in `T`, or when the query doesn't return that column, because the code and the schema disagree. `rset->getOrDefault<T>("column", fallback)` returns the fallback for `NULL`.

### `db::transaction`

```cpp
const auto committed = db::transaction(
    [&]
    {
        if (!db::preparedStmt("UPDATE ...", ...))
        {
            throw std::runtime_error("Failed to update ...");
        }

        if (!db::preparedStmt("INSERT ...", ...))
        {
            throw std::runtime_error("Failed to insert ...");
        }
    });
```

A failed statement returns `nullptr` and doesn't throw, so check each one. It rolls back if the function throws anything, and returns true only if the `COMMIT` succeeds. A transaction started inside another one joins it, so a throw rolls back the outer transaction too.

### `db::executeBulk`

Sends many rows through one statement in one round trip. The projection turns each row into a tuple of numbers, bools or enums, one per `?`. It throws if the statement fails, so call it inside `db::transaction`.

```cpp
db::executeBulk(
    "INSERT INTO char_effects (charid, effectid, power) VALUES (?, ?, ?)",
    effects,
    [&](const auto& effect)
    {
        return std::tuple{ PChar->id, effect.id, effect.power };
    });
```

### Strict mode

Every connection adds `STRICT_TRANS_TABLES` to the session's `sql_mode`. A value that is out of range or too long for its column makes the statement fail. It isn't clamped or truncated.
