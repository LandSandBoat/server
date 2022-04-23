#include "../src/map/utils/moduleutils.h"

class CustomCPPModule : public CPPModule
{
    // Required
    void OnInit() override
    {
        TracyZoneScoped;
        // Called at the end of on_init

        // Regular logging is available
        //ShowInfo("Hello from CustomCPPModule!");

        // "lua" and "sql" are available inside this class
        //lua["print"]("Hello from CustomCPPModule's Lua!");

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
    }

    // Optional
    void OnZoneTick(CZone* PZone) override
    {
        TracyZoneScoped;
        // Called every 400ms, once for each zone
    }

    // Optional
    void OnTimeServerTick() override
    {
        TracyZoneScoped;
        // Called every 2400ms
    }

    // Optional
    void OnCharZoneIn(CCharEntity* PChar) override
    {
        TracyZoneScoped;
        // Called after a character has zoning in
    }

    // Optional
    void OnCharZoneOut(CCharEntity* PChar) override
    {
        TracyZoneScoped;
        // Called when a character is about to zone out
    }
};

REGISTER_CPP_MODULE(CustomCPPModule);
