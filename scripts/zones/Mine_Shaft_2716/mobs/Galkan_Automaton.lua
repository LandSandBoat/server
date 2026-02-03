-----------------------------------
-- Area: Mine Shaft 2716
-- ENM : Automaton Assault
-- Mob: Galkan Automaton
-----------------------------------
---@type TMobEntity
local entity = {}
-----------------------------------
local orderIndex = 4
-----------------------------------

local raceKey =
{
    [xi.race.HUME_M  ] = 0,
    [xi.race.HUME_F  ] = 0,
    [xi.race.ELVAAN_M] = 1,
    [xi.race.ELVAAN_F] = 1,
    [xi.race.TARU_M  ] = 2,
    [xi.race.TARU_F  ] = 2,
    [xi.race.MITHRA  ] = 3,
    [xi.race.GALKA   ] = 4,
}

local function callNextAutomaton(mob, target, nextOrderIndex)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local replacedSlot        = raceKey[battlefield:getLocalVar('initiatorRace')] or 0
    local nextAutomatonOffset = (nextOrderIndex % 4) + 1 -- Next slot in line, looping back to 1 after 4 using modulo (4 % 4 = 0 + 1 = 1)

    -- If an Automaton has been replaced and that Automaton is the next in line, call the Hume Automaton instead.
    if
        replacedSlot ~= 0 and
        replacedSlot == nextAutomatonOffset
    then
        nextAutomatonOffset = 0
    end

    -- Base ID for the Hume Automaton in the current battlefield area.
    local baseId = zones[xi.zone.MINE_SHAFT_2716].mob.HUME_AUTOMATON + (battlefield:getArea() - 1) * 6

    -- Get the next automaton based on calculated offset.
    local nextAutomaton = GetMobByID(baseId + nextAutomatonOffset)
    if not nextAutomaton then
        return false
    end

    if not nextAutomaton:isAlive() then
        return false
    end

    nextAutomaton:updateEnmity(target) -- Call the next automaton to engage the target.
    return true                        -- Return true to set automatonCalled to 1.
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.BIND_RES_RANK, 9)
    --mob:setMod(xi.mod.GRAVITY_RES_RANK, 9)
    mob:setMod(xi.mod.UDMGMAGIC, 10000)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMagicCastingEnabled(false)

    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setLocalVar('nextAutomatonCalled', 0)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() >= 10 then
        return
    end

    if mob:getLocalVar('nextAutomatonCalled') == 1 then
        return
    end

    if callNextAutomaton(mob, target, orderIndex) then
        mob:setLocalVar('nextAutomatonCalled', 1)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.HARD_SLASH_1,
        xi.mobSkill.POWER_SLASH_1,
        xi.mobSkill.FROSTBITE_1,
        xi.mobSkill.FREEZEBITE_1,
        xi.mobSkill.SHOCKWAVE_1,
        xi.mobSkill.CRESCENT_MOON_1,
        xi.mobSkill.SICKLE_MOON_1,
    }

    return skills[math.random(1, #skills)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        if
            mob:getLocalVar('nextAutomatonCalled') == 0 and
            callNextAutomaton(mob, player, orderIndex)
        then
            mob:setLocalVar('nextAutomatonCalled', 1)
        end
    end
end

return entity
