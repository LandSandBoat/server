-----------------------------------------
-- Checks if players have Aeonic unlocked
-----------------------------------------
require("scripts/globals/weaponskillids")

xi = xi or {}
xi.aeonics = xi.aeonics or {}

xi.aeonics.onTrigger = function(player, wsID)
    local aTable =
    {
        [1 ] = { "hasExenteratorUnlock",  xi.weaponskill.EXENTERATOR   },
        [2 ] = { "hasShattersoulUnlock",  xi.weaponskill.SHATTERSOUL   },
        [3 ] = { "hasShijinSpiralUnlock", xi.weaponskill.SHIJIN_SPIRAL },
        [4 ] = { "hasRealmrazerUnlock",   xi.weaponskill.REALMRAZER    },
        [5 ] = { "hasShattersoulUnlock",  xi.weaponskill.SHATTERSOUL   },
        [6 ] = { "hasRequiescatUnlock",   xi.weaponskill.REQUIESCAT    },
        [7 ] = { "hasApexArrowUnlock",    xi.weaponskill.APEX_ARROW    },
        [8 ] = { "hasEntropyUnlock",      xi.weaponskill.ENTROPY       },
        [9 ] = { "hasRuinatorUnlock",     xi.weaponskill.RUINATOR      },
        [10] = { "hasTachiShohaUnlock",   xi.weaponskill.TACHI_SHOHA   },
        [11] = { "hasBladeShunUnlock",    xi.weaponskill.BLADE_SHUN    },
        [12] = { "hasExenteratorUnlock",  xi.weaponskill.EXENTERATOR   },
        [13] = { "hasLastStandUnlock",    xi.weaponskill.LAST_STAND    },
        [14] = { "hasStardiverUnlock",    xi.weaponskill.STARDIVER     },
        [15] = { "hasResolutionUnlock",   xi.weaponskill.RESOLUTION    },
        [16] = { "hasUpheavalUnlock",     xi.weaponskill.UPHEAVAL      },
    }

    if player:isPC() then
        for i = 1, 16 do
            local unlockVar = player:getCharVar(aTable[i][1])
            local usedWs    = aTable[i][2]
            
            if wsID == usedWs then
                if unlockVar == 1 then
                    return true
                else
                    player:PrintToPlayer("You don't have this WS unlocked")
                    return false
                end

                break
            end
        end
    end
end