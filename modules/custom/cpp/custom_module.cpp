#include "../src/map/utils/moduleutils.h"

class CustomCPPModule : public CPPModule
{
    // Required
    void OnInit() override
    {
        // Called at the end of on_init

        // "lua" and "sql" are available inside this class

        lua["print"]("Hello!");

        // Register custom bindings
        /*
        lua["CBaseEntity"]["MyNewFunction"] = [](CLuaBaseEntity* PLuaBaseEntity)
        {
            auto* PEntity = PLuaBaseEntity->GetBaseEntity()
            if (PEntity->objtype == TYPE_PC)
            {
                // Do stuff
            }
        };
        */

        // Run a SQL query
        /*
        int32  ret = sql->Query("SELECT COUNT(*) FROM chars WHERE charid = 1 AND accid = 1 LIMIT 1;");
        if (ret == SQL_ERROR || sql->NextRow() != SQL_SUCCESS || sql->GetUIntData(0) == 0)
        {
            // Do stuff
        }
        */

       sql->NextRow();
    }

    // Optional
    void OnZoneTick() override
    {
        // Called every 400ms, once for each zone
    }

    // Optional
    void OnTimeServerTick() override
    {
        // Called every 2400ms
    }

    // Optional
    void OnCharZoneIn() override
    {
        // Called after a character has zoning in
    }

    // Optional
    void OnCharZoneOut() override
    {
        // Called when a character is about to zone out
    }
};

REGISTER_CPP_MODULE(CustomCPPModule);
