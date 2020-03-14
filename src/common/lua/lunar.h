#pragma once
#include "lua.hpp"
/*Связыватель объектов C++ с объектами Lua*/
template <typename T> class Lunar {

  /*Структура инкапсулирования объекта C++ в объект Lua*/
  struct user_t
  {
	  T *pT;
  };
public:
  typedef int (T::*mfp)(lua_State *L);

  /* Стуктура для склеивания методов объекта Lua с методами объекта C++*/
  struct Register_t
  {
	  const char *name;
	  mfp mfunc;
  };

  static void Register(lua_State *L) {

    /* [1] - таблица методов объекта */
    lua_newtable(L);
    int methods = lua_gettop(L);

	/* [2] - метатаблица будущих обектов*/
    luaL_newmetatable(L, T::className);
    int metatable = lua_gettop(L);

    // Размещение таблицы методов в глобальной переменной
	// для того, чтобы код lua мог добавлять методы.
    lua_pushvalue(L, methods);
    lua_setglobal(L, T::className);

    // прячем метатаблицу от getmetattable()
    lua_pushvalue(L, methods);
    set(L, metatable, "__metatable");

	// Задаем значение поля __index мета таблицы
	// адресом таблицы методов, для того чтобы
	// можно было использовать синтекс obj:method()
    lua_pushvalue(L, methods);
    set(L, metatable, "__index");

	// Задаем значение поля __tostring мета таблицы,
	// для того, чтобы можно было выводить объект в текстовом виде.
    lua_pushcfunction(L, tostring_T);
    set(L, metatable, "__tostring");

	// Задаем значение поля __gc  мета таблицы
	// для того, чтобы сборщик мусора мог удалить нанаши объекты
    lua_pushcfunction(L, gc_T);
    set(L, metatable, "__gc");

	// Добавляем новую таблицу для того, чтобы
	// сделать её метатаблице таблицы методов.
    lua_newtable(L);                // mt
	// Добавление функции сосздания объекта
    lua_pushcfunction(L, new_T);
    lua_pushvalue(L, -1);           // копирование адреса функции для двух случаев.
	// задаем метод new у таблицы, для реализации конструктора
	// Class:new()
    set(L, methods, "new");         //
	// Задаем метод __call у мета таблицы для того, чтобы
	// можно было использовать метод Class().
    set(L, -3, "__call");           // mt.__call = new_T
    lua_setmetatable(L, methods);

    // Заполнение таблицы lua, методами из класса.
    for (Register_t *l = T::methods; l->name; ++l) {
	  // добавление имени метода
      lua_pushstring(L, l->name);
	  // добавление склеивающего параметра.
      lua_pushlightuserdata(L, (void*)l);
	   // добавление специального склеивателя.
      lua_pushcclosure(L, thunk, 1);

      lua_settable(L, methods);
    }

    lua_pop(L, 2);
  }

  // Вызов метода из user_t
  static int call(lua_State *L, const char *method,
                  int nargs=0, int nresults=LUA_MULTRET, int errfunc=0)
  {
	// Идекс в стеке для user_t
    int base = lua_gettop(L) - nargs;
	// Проверка типа user_t
    if (!luaL_checkudata(L, base, T::className)) {
      lua_settop(L, base-1);           // Удаление всех данных
      lua_pushfstring(L, "not a valid %s userdata", T::className);
      return -1;
    }

    lua_pushstring(L, method);         // имя метода
    lua_gettable(L, base);             // получить method из userdata
    if (lua_isnil(L, -1)) {            // Метод найден?
      lua_settop(L, base-1);           // Удаление всех данных
      lua_pushfstring(L, "%s missing method '%s'", T::className, method);
      return -1;
    }
    lua_insert(L, base);               // put method under userdata, args

    int status = lua_pcall(L, 1+nargs, nresults, errfunc);  // Вызов метода
    if (status) {
      const char *msg = lua_tostring(L, -1);
      if (msg == NULL) msg = "(error with no message)";
      lua_pushfstring(L, "%s:%s status = %d\n%s",
                      T::className, method, status, msg);
      lua_remove(L, base);             // remove old message
      return -1;
    }
    return lua_gettop(L) - base + 1;   // кол-во возвращенных результатов
  }

  // Добавление в стек пользовательского типа данных, содержащего указатель на
  // T *obj
  static int push(lua_State *L, T *obj, bool gc=false) {
    if (!obj)
	{
		lua_pushnil(L);
		return 0;
	}
    luaL_getmetatable(L, T::className);  // поиск мета-таблицы в реестре.
    if (lua_isnil(L, -1)) luaL_error(L, "%s missing metatable", T::className);
    int mt = lua_gettop(L);
    subtable(L, mt, "userdata", "v");

	user_t *ud =
      static_cast<user_t*>(pushuserdata(L, obj, sizeof(user_t)));
    if (ud) {
      ud->pT = obj;  // размещение указателя в user_t
      lua_pushvalue(L, mt);
      lua_setmetatable(L, -2);
      if (gc == false) {
        lua_checkstack(L, 3);
        subtable(L, mt, "do not trash", "k");
        lua_pushvalue(L, -2);
        lua_pushboolean(L, 1);
        lua_settable(L, -3);
        lua_pop(L, 1);
      }
    }
    lua_replace(L, mt);
    lua_settop(L, mt);
    return mt;  // index  userdata содержит указатель на T *obj
  }

  // возврат T* из стека
  static T *check(lua_State *L, int narg) {
    user_t *ud =
      static_cast<user_t*>(luaL_checkudata(L, narg, T::className));
    if(!ud) {
        luaL_typerror(L, narg, T::className);
        return NULL;
    }
    return ud->pT;  // pointer to T object
  }

private:
  Lunar();  // прячем конструктор по умолчанию.

  // распаковщик функции члена.
  static int thunk(lua_State *L) {
    // стек содержит user_t, следующим прямо за аргументами.
    T *obj = check(L, 1);
    lua_remove(L, 1);
    // Получаем связанное с распаковщиком значение registration
    Register_t *l = static_cast<Register_t*>(lua_touserdata(L, lua_upvalueindex(1)));
    return (obj->*(l->mfunc))(L);  // Вызов метода объекта.
  }

  // Создание нового объекта и добавление его на вершину стека
  static int new_T(lua_State *L) {
    lua_remove(L, 1);   // удаление 'self'
    T *obj = new T(L);  // Вызов конструктора
    push(L, obj, true); // gc_T удалит этот объект когда надо
    return 1;
  }

  // сборщик мусора
  static int gc_T(lua_State *L) {
    if (luaL_getmetafield(L, 1, "do not trash")) {
      lua_pushvalue(L, 1);  // dup userdata
      lua_gettable(L, -2);
      if (!lua_isnil(L, -1)) return 0;  // do not delete object
    }
    user_t *ud = static_cast<user_t*>(lua_touserdata(L, 1));
    T *obj = ud->pT;
    if (obj) delete obj;
    return 0;
  }

  static int tostring_T (lua_State *L) {
    char buff[32];
    user_t *ud = static_cast<user_t*>(lua_touserdata(L, 1));
    T *obj = ud->pT;
    sprintf(buff, "%p", (void*)obj);
    lua_pushfstring(L, "%s (%s)", T::className, buff);
    return 1;
  }

  static void set(lua_State *L, int table_index, const char *key) {
    lua_pushstring(L, key);
    lua_insert(L, -2);  // swap value and key
    lua_settable(L, table_index);
  }

  static void weaktable(lua_State *L, const char *mode) {
    lua_newtable(L);
    lua_pushvalue(L, -1);  // table is its own metatable
    lua_setmetatable(L, -2);
    lua_pushliteral(L, "__mode");
    lua_pushstring(L, mode);
    lua_settable(L, -3);   // metatable.__mode = mode
  }

  static void subtable(lua_State *L, int tindex, const char *name, const char *mode) {
    lua_pushstring(L, name);
    lua_gettable(L, tindex);
    if (lua_isnil(L, -1)) {
      lua_pop(L, 1);
      lua_checkstack(L, 3);
      weaktable(L, mode);
      lua_pushstring(L, name);
      lua_pushvalue(L, -2);
      lua_settable(L, tindex);
    }
  }

  static void *pushuserdata(lua_State *L, void *key, size_t sz) {
    void *ud = 0;
    lua_pushlightuserdata(L, key);
    lua_gettable(L, -2);     // lookup[key]
    if (lua_isnil(L, -1)) {
      lua_pop(L, 1);         // drop nil
      lua_checkstack(L, 3);
      ud = lua_newuserdata(L, sz);  // create new userdata
      lua_pushlightuserdata(L, key);
      lua_pushvalue(L, -2);  // dup userdata
      lua_settable(L, -4);   // lookup[key] = userdata
    }
    return ud;
  }
};

#define LUNAR_DECLARE_METHOD(Class, Name) {#Name, &Class::Name}
