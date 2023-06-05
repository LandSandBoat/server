-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Wind Golem
-- BCNM: Idol Thoughts
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "GOLEM_WEAPONSKILL__STATE_ENTER", function(mobArg, skillID)
        local bfNum = mob:getBattlefield():getArea()
        print(1)

        if mobArg:getLocalVar("control") == 0 then
            for i = 0, 3 do
                local golem = GetMobByID(ID.mob.IDOL_THOUGHTS[bfNum][i + 1])
                golem:setLocalVar("control", 1)

                if golem:getID() ~= mobArg:getID() then
                    -- Crystal Weapon (Elemental)
                    if skillID == 681 then
                        golem:useMobAbility(679 + i)

                    -- Ice Break / Thunder Break
                    elseif skillID == 676 or skillID == 677 then
                        if i < 2 then
                            golem:useMobAbility(676)
                        else
                            golem:useMobAbility(677)
                        end
                    -- Default Case
                    else
                        golem:useMobAbility(skillID)
                    end
                end

                golem:timer(5000, function(golemArg)
                    golemArg:setLocalVar("control", 0)
                end)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
