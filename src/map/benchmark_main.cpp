#include <benchmark/benchmark.h>

#include "common/lua.h"

#include "map/entities/baseentity.h"
#include "map/entities/battleentity.h"
#include "map/entities/charentity.h"
#include "map/entities/mobentity.h"
#include "map/spell.h"

#include "map/lua/luautils.h"

#include "map/modifier.h"

struct TestHarness
{
    TestHarness()
    {
        logging::InitializeLog("bench", "log/bench.log", false);
        lua_init();
        settings::init();

        PChar = new CCharEntity();
        PMob  = new CMobEntity();
    }

    ~TestHarness()
    {
        delete PChar;
        delete PMob;
    }

    CCharEntity* PChar;
    CMobEntity*  PMob;
};

static void BM_NativeCpp(benchmark::State& state)
{
    // Perform setup here
    TestHarness th;

    for (auto _ : state)
    {
        // Code in here is measured
        auto att = th.PChar->getMod(Mod::ATT);
        auto def = th.PMob->getMod(Mod::DEF);
        auto diff = att - def;
        th.PMob->addHP(diff);
    }
}
BENCHMARK(BM_NativeCpp);

/*
static void BM_ModuleCpp(benchmark::State& state)
{
    // Perform setup here
    TestHarness th;

    for (auto _ : state)
    {
        // Code in here is measured
        auto att = th.PChar->getMod(Mod::ATT);
        auto def = th.PMob->getMod(Mod::DEF);
        auto diff = att - def;
        th.PMob->addHP(diff);
    }
}
BENCHMARK(BM_ModuleCpp);
*/

static void BM_PartialLua(benchmark::State& state)
{
    // Perform setup here
    TestHarness th;

    lua.script("someFunc = function(att, def) return att - def end");

    for (auto _ : state)
    {
        // Code in here is measured
        auto someFunc = lua["someFunc"];
        if (!someFunc.valid())
        {
            sol::error err = someFunc;
            ShowError("someFunc: %s", err.what());
            return;
        }

        auto att = th.PChar->getMod(Mod::ATT);
        auto def = th.PMob->getMod(Mod::DEF);

        auto result = someFunc(att, def);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("someFunc: %s", err.what());
            return;
        }

        auto diff = result.get<int32>();
        th.PMob->addHP(diff);
    }
}
BENCHMARK(BM_PartialLua);

/*
static void BM_FullLua(benchmark::State& state)
{
    // Perform setup here
    TestHarness th;

    for (auto _ : state)
    {
        // Code in here is measured
        auto att = th.PChar->getMod(Mod::ATT);
        auto def = th.PMob->getMod(Mod::DEF);
        auto diff = att - def;
        th.PMob->addHP(diff);
    }
}
BENCHMARK(BM_FullLua);
*/

// Run the benchmarks
BENCHMARK_MAIN();
