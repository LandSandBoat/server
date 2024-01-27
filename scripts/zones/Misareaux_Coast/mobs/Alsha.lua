-----------------------------------
--  Area: Misareaux Coast
--    NM: Alsha
-- Quest: Knocking on Forbidden Doors
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('CureTime', os.time() + math.random(60, 180)) -- anywhere from every 1-3 minutes
end

entity.onMobFight = function(mob, target)
    -- Check to see if below 20% HPP, and set the 'final mode' active
    if mob:getLocalVar('FinalPhase') ~= 1 and mob:getHPP() < 20 then
        target:messageSpecial(ID.text.LARGE_DROPS_OF_OIL)
        mob:setLocalVar('FinalPhase', 1)
        -- TODO: Uncomment these lines
        -- Fix code below so that Alsha will cast Fire II on herself.  Currently not possible without core changes.
        --mob:setAutoAttackEnabled(false)
        --mob:setMagicCastingEnabled(false)
    end
--[[
    -- Queue up a Fire II on herself if FinalPhase is active
    if mob:getLocalVar('FinalPhase') == 1 and mob:getLocalVar('Casting') ~= 1 then
        mob:setLocalVar('Casting', 1)
        mob:setMP(10000) -- Never will run out at this stage
        mob:timer(6500, function(m)
            m:setLocalVar('Casting', 0)
        end)
        -- mob:castSpell(145, mob) -- 145 = Fire II
    end
]]
    -- Occasionally cast Cure III on the target (never on herself)
    if
        mob:getLocalVar('FinalPhase') ~= 1 and
        mob:getLocalVar('CureTime') <= os.time()
    then
        mob:setLocalVar('CureTime', os.time() + math.random(60, 180))
        target:messageSpecial(ID.text.DROP_OF_OIL)
        mob:timer(1000, function(m)
            m:castSpell(3, target) -- Cure III
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Requires logic to ensure Alsha is killed by a player and not by herself.
end

return entity
