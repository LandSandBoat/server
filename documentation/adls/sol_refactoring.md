### Title
Sol refactoring, with lua object caching.

### What was/is the problem?
Multiple problems, explained in detail [here](https://github.com/topaz-next/topaz/wiki/Sol-Refactor).

In short:
- Our use of Lua relied on constantly reading files from this disk, which was very slow.
- Lua binding library was hard to use.
- Errors on the boundary between C++ and Lua would cause undefined behaviour or crashes.

### What were/are the options?
Only Sol was considered.

### What was chosen?
[Sol](https://github.com/ThePhD/sol2/)

- After the refactor, Lua panics resulting in crashes were eliminated entirely (unless you abuse LuaJIT very badly).
- Misusing bindings is caught before any native code is executed, eliminating crashes in bindings.
- As mentioned in the [refactor notes](https://github.com/topaz-next/topaz/wiki/Sol-Refactor), performance is through the roof.
- Writing complex bindings is safe and easy.

### Misc Notes
#### Caching
By the end of the refactor, the additional Lua memory usage was only 30mb.
Every new item that gets added to the Lua cache is taking up memory at runtime.
If this ever gets to be too much (it shouldn't), a cache eviction policy could be written. This could clear out items that haven't been accessed in the last couple of hours.
Unlikely to ever be needed.

#### Compatibility with LuaJIT
Our use of Lua relies on LuaJIT, which functions a lot like Lua 5.1. Sol uses a series of polyfills to bring the language features up to 5.2/5.3.
This introduces some breaking changes around number truncation. We have a reverse polyfill to undo these changes, details are available in `src/map/lua/luautils.h`.

There are a few gotcha's using Sol on top of LuaJIT, the only one that we had to pay attention to was the use of the `obj:pairs()/obj:ipairs()` binding, which doesn't work. This is easily worked around by wrapping your object with the `pairs(obj)/ipairs(obj)` helper.

Another important gotcha is the creation of tables in cpp-land. Creating a `sol::table` object doesn't create a table inside the lua state. Tables need to be obtained from existing objects or created with `get_or_create()` or similar.
