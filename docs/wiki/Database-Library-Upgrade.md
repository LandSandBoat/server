**TLDR:**

>- Retire the Windows 32-bit build.
>- Updated the existing `mariadb-connector-c` library.
>- Introduce the `mariadb-connector-cpp` library, which wraps the `mariadb-connector-cpp` with better usage patterns.
>- Add an API on top of `mariadb-connector-cpp` that can be used alongside our current SQL usage.
>- All instances of `sql` global object are replaced with `_sql` because of clashing symbols in the new library. The goal is to eventually replace these with their new `db` namespace equivalents.
>- The new API provides:
>    - Thread-safe usage.
>    - Protection from clobbering your results by interleaving queries.
>    - Option to extract column results of queries by column name rather than by index.
>    - Additional safety through use of prepared statements.
>    - Equivalent-or-better performance.

## Introduction

## The PR

<https://github.com/LandSandBoat/server/pull/4601>

## What does this mean for my server?

As a player or an operator; nothing. This is primarily a change to help core developers.

### Safety & Developer Quality of Life

Currently, it's very easy to trip yourself up while using the existing code built on top of `mariadb-connector-c`. If you have more than one query in flight on a single connection, you'll clobber the data of your first query. In addition to being very careful, we have had to build many checks and warnings on top of the connector to make it safer an easier to use.

If you have many columns of data to pull from the results of your query, you've previously had to keep them in order and index into the results. If you needed to add or remove columns, you'd have to update all of your indexes. Quite fragile, and this has been the cause of more than a couple of bugs over the last few years.

The new `mariadb-connector-cpp` library fixes both of these issues and provides other goodies for developers. Your query results are stored away into a `Result Set` object, which is safe from clobbering if you want to do other things while you iterate your results. You can now ask your `Result Set` for results by name, rather than index - making it a lot more robust.

It also introduces [Prepared Statements](https://en.wikipedia.org/wiki/Prepared_statement); which boosts efficieny of calling queries by not having to recompile each query from a string on every call, and adds an additional layer of protection for converted queries from [SQL injection](https://en.wikipedia.org/wiki/SQL_injection) attacks.

## What's Next?

Currently, it isn't possible to use `db::encodeToBlob` inline with `db::preparedStmt`. This is first on the list to try and fix. After this, keeping a pool of connections behind the scene which can be "checked out" by callers and then returned to the pool when they're finished doing their work. Maybe combining the new `db::` namespace with `async`.  

## Usage and Query Migration Guide

The new API looks like this:

- note that `ret` (Return Code) and `rset` (Result Set) are very different things!

### `db::query`

```cpp
// Send in a simple string query and don't check the results
auto query = fmt::format("UPDATE char_stats SET zoning = 0 WHERE charid = {}", PChar->id);
db::query(query);

// Send in a simple string query and check the results
if (!db::query(...))
{
    ShowError("Failed to update daily tally points");
}
else
{
    ShowDebug("Distributed daily tally points");
}

// Send in a simple string query and extract out a single result
auto rset = db::query(...);
if (rset && rset->rowsCount() && rset->next() // If there is a result. Equivalent to `if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)`
{
    const auto itemid = rset->getInt("itemid"); // Extract data by column name from the `rset`, not the database connection object
    ...
}

// Send in a simple string query and extract out multiple rows of results
auto rset = db::query(...);
if (rset && rset->rowsCount()) // If there are results: Equivalent to `if (ret != SQL_ERROR && _sql->NumRows() != 0)`
{
    while (rset->next()) // Iterate over your results. Equivalent to `while (_sql->NextRow() == SQL_SUCCESS)`
    {
        const auto itemid = rset->getInt("itemid"); // Extract data by column name from the `rset`, not the database connection object
        ...
    }
}
```

### `db::preparedStmt`

There is a lot of plumbing going on behind the scenes to shield you from having to manage your own prepared statement objects.
They are lazily constructed and cached on your behalf.

```cpp
const char* query = "SELECT set_blue_spells FROM "
                    "chars WHERE charid = ?;";  // <-- Note the dynamic parameter slot here

// The prepared statement will be created, cached, and bound for you behind the scenes
auto rset = db::preparedStmt(query, PChar->id);
if (rset && rset->rowsCount() && rset->next()) // Inspect and iterate as normal
{
    db::extractFromBlob(rset, "set_blue_spells", PChar->m_SetBlueSpells);
}
```

### `db::encodeToBlob`

To write structs into the database, they must be encoded with `db::encodeToBlob` and baked into a query string with `fmt::format`, for execution with `db::query`. This replaces the `char buffer[T * 2 + 1]; std::memcpy(...)` pattern seen in many places in the codebase. Eventually it'll be possible to use `db::encodeToBlob` inline with `db::preparedStmt` and `db::query` will be extended to be variadic and forward arguments interally to `fmt::format`.

```cpp
    auto set_blue_spells = db::encodeToBlob(PChar->m_SetBlueSpells);
    auto query           = fmt::format("UPDATE chars SET set_blue_spells = '{}' WHERE charid = {} LIMIT 1",
                                        set_blue_spells, PChar->id);
    db::query(query);
```
