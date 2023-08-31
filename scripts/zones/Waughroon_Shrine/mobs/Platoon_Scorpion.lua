-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
local entity = {}

local mimicDistance = 15
-- 25% should cover: 'sometimes after ... ' - https://ffxiclopedia.fandom.com/wiki/Operation_Desert_Swarm
local selfBindChance = 0.25  -- 25%
local selfStunChance = 0.25  -- 25%

-- Mobs sync/mimic TP moves.

entity.onMobInitialize = function(scorpion)
    scorpion:addListener('WEAPONSKILL_STATE_ENTER', 'SCORP_MIMIC_START', function(mob, skillID)
        -- check flag to make sure we aren't infinitely looping through scorps
        if mob:getLocalVar('[ODS]mimic') ~= 1 then
            local bf = mob:getBattlefield():getArea()
            local mobId = mob:getID() -- prevent self-triggering: eg using wild rage making the user use more wild rage

            for _, allyId in ipairs(ID.operationDesertSwarm[bf]) do
                -- prevent self-triggering
                if mobId ~= allyId then
                    local potentialMimic = GetMobByID(allyId)
                    local dist = mob:checkDistance(potentialMimic)

                    if dist < mimicDistance then
                        -- set flag so prevent infinite loops
                        potentialMimic:setLocalVar('[ODS]mimic', 1)
                        if skillID == 354 then
                            potentialMimic:useMobAbility(354)
                        elseif skillID == 355 then
                            potentialMimic:useMobAbility(355)
                        end
                    end
                end
            end
        end
    end)

    scorpion:addListener('WEAPONSKILL_STATE_EXIT', 'SCORP_MIMIC_STOP', function(mob, skillID)
        -- reset infinite loop flag
        mob:setLocalVar('[ODS]mimic', 0)

        -- Sometimes Wild Rage self stuns and sometimes Earth Pounder self binds
        -- https://ffxiclopedia.fandom.com/wiki/Operation_Desert_Swarm
        --
        if skillID == 354 and math.random() < selfStunChance then
            -- Wild Rage
            mob:showText(mob, ID.text.SCORPION_IS_STUNNED)
            mob:addStatusEffect(xi.effect.STUN, 0, 0, 10)
            -- Earth Pounder
        elseif skillID == 355 and math.random() < selfBindChance then
            mob:showText(mob, ID.text.SCORPION_IS_BOUND)
            mob:addStatusEffect(xi.effect.BIND, 0, 0, 10)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        -- This is used to increase the strength of Wild Rage as scorps die
        local bf = mob:getBattlefield()
        -- should not have to verify because Platoon scorps are only ever in a BC
        local numScorpsDead = bf:getLocalVar('[ODS]NumScorpsDead')
        bf:setLocalVar('[ODS]NumScorpsDead', numScorpsDead + 1)
    end
end

return entity
