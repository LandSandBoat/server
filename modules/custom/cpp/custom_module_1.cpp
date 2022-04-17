#include "../src/map/utils/moduleutils.h"
#include <iostream>

class CustomModule1 : public CPPModule
{
    void OnInit() override
    {
        std::cout << "Module1\n";

        // Register custom bindings
        /*
        auto& lua = luautils::lua;
        lua["CBaseEntity"]["MyNewFunction"] = [](CLuaBaseEntity* PLuaBaseEntity)
        {
            auto* PEntity = PLuaBaseEntity->GetBaseEntity()
            if (PEntity->objtype == TYPE_PC)
            {
                // Do stuff
            }
        };
        */
    }

    void OnTick() override
    {

    }

    void OnCharZoneIn() override
    {

    };

    void OnCharZoneOut()
    {

    }
};

REGISTER_CPP_MODULE(CustomModule1);
