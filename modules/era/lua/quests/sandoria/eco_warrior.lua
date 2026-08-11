-----------------------------------
-- Eco-Warrior (San d'Oria)
-- Restores the level 20 restriction on the ointment.
-- The June 25, 2015 version update raised the level cap from 20 to 25.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/47481
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_eco_warrior_sandoria', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Eco_Warrior', function(quest)
        local ordellesCaves = quest.sections[2][xi.zone.ORDELLES_CAVES]

        -- Copy of the base handler with the level restriction lowered to 20.
        ordellesCaves.onEventFinish[51] = function(player, csid, option, npc)
            if option == 1 then
                player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                    power    = 20, -- Module change: the level restriction is 20.
                    subPower = 1,  -- exp uses actual level and not the restricted level.
                    origin   = player,
                    flag     = xi.effectFlag.ON_ZONE
                })
            end
        end
    end)
end)
