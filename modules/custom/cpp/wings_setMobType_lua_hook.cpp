#include "../src/map/lua/lua_baseentity.h"
#include "../src/map/entities/baseentity.h"
#include "../src/map/entities/mobentity.h"
#include "../src/map/utils/moduleutils.h"

class CustomCPPModule : public CPPModule
{
    // Required
    void OnInit() override
    {
        TracyZoneScoped;

       lua["CBaseEntity"]["setMobType"] = [](CLuaBaseEntity* PLuaBaseEntity, uint8 mobType)
       {
           CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();

            if (PEntity->objtype != TYPE_MOB)
            {   
                return 0;
            }

           if (mobType >= MOBTYPE::MOBTYPE_NORMAL && mobType <= MOBTYPE::MOBTYPE_EVENT)
            {
                ((CMobEntity*)PEntity)->m_Type = mobType;
            }
            
            return 0;
       };

    }
};

REGISTER_CPP_MODULE(CustomCPPModule);
