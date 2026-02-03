-----------------------------------
-- Area: Mine Shaft 2716
-- ENM : Automaton Assault
-- Mob: Hume Automaton
-----------------------------------
---@type TMobEntity
local entity = {}
-----------------------------------

-- Spawn points of all possible replacements
local spawnPoints =
{
    [1] = -- Elvaan
    {
        [1] = { x = -466.000, y =  121.704, z = 26.000, rot = 64 },
        [2] = { x =   14.138, y =    1.704, z = 22.883, rot = 64 },
        [3] = { x =  494.362, y = -118.296, z = 22.365, rot = 64 },
    },

    [2] = -- Tarutaru
    {
        [1] = { x = -462.000, y =  121.637, z = 26.000, rot = 64 },
        [2] = { x =   18.138, y =    1.637, z = 22.883, rot = 64 },
        [3] = { x =  498.362, y = -118.363, z = 22.365, rot = 64 },
    },

    [3] = -- Mithra
    {
        [1] = { x = -458.000, y =  121.637, z = 26.000, rot = 64 },
        [2] = { x =   22.138, y =    1.637, z = 22.883, rot = 64 },
        [3] = { x =  502.362, y = -118.363, z = 22.365, rot = 64 },
    },

    [4] = -- Galka
    {
        [1] = { x = -454.000, y =  121.704, z = 26.000, rot = 64 },
        [2] = { x =   26.138, y =    1.704, z = 22.883, rot = 64 },
        [3] = { x =  506.362, y = -118.296, z = 22.365, rot = 64 },
    },
}

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

local function callNextAutomaton(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return false
    end

    local replacedSlot   = battlefield:getLocalVar('replacedSlot') -- Returns 1-4 based on which automaton is being replaced
    local nextSlotOffset = (replacedSlot % 4) + 1 -- Next slot in line, looping back to 1 after 4 using modulo (4 % 4 = 0 + 1 = 1)

    -- Base ID for the Hume Automaton in the current battlefield area.
    local baseId = mob:getID()

    -- Get the next automaton based on calculated offset.
    local nextAutomaton = GetMobByID(baseId + nextSlotOffset)
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
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local raceIndex  = raceKey[battlefield:getLocalVar('initiatorRace')]
    if raceIndex == 0 then
        return
    end

    local spawnPoint = spawnPoints[raceIndex][battlefield:getArea()]
    mob:setSpawn(spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.rot)
    mob:setPos(spawnPoint.x, spawnPoint.y, spawnPoint.z)

    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setLocalVar('nextAutomatonCalled', 0)

    -- Elvaan
    if raceIndex == 1 then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        mob:setMagicCastingEnabled(false)
        mob:setMaxHP(3000)
        mob:setHP(3050)

    -- Tarutaru
    elseif raceIndex == 2 then
        mob:setMod(xi.mod.UDMGPHYS, 10000)
        mob:setMod(xi.mod.UDMGMAGIC, -9500)
        mob:setMod(xi.mod.UDMGRANGE, -5000)
        mob:setMod(xi.mod.MATT, 76)
        mob:setMod(xi.mod.FASTCAST, 20)
        mob:setMagicCastingEnabled(true)
        mob:setMaxHP(2000)
        mob:setHP(2050)

    -- Mithra
    elseif raceIndex == 3 then
        mob:setMod(xi.mod.UDMGRANGE, 10000)
        mob:setMod(xi.mod.UDMGMAGIC, -9500)
        mob:setMod(xi.mod.UDMGPHYS, -5000)
        mob:setMod(xi.mod.EVA, 240)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
        mob:setMaxHP(2800)
        mob:setHP(2850)
        mob:setMagicCastingEnabled(false)

    -- Galka
    elseif raceIndex == 4 then
        mob:setMod(xi.mod.UDMGMAGIC, 10000)
        mob:setMod(xi.mod.UDMGPHYS, -9500)
        mob:setMod(xi.mod.UDMGRANGE, -5000)
        mob:setMaxHP(3500)
        mob:setHP(3550)
        mob:setMagicCastingEnabled(false)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() >= 10 then
        return
    end

    if mob:getLocalVar('nextAutomatonCalled') == 1 then
        return
    end

    if callNextAutomaton(mob, target) then
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

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.STONEGA_II,
        xi.magic.spell.WATERGA_II,
        xi.magic.spell.AEROGA_II,
        xi.magic.spell.FIRAGA_II,
        xi.magic.spell.BLIZZAGA_II,
        xi.magic.spell.THUNDAGA_II,
    }

    return spellList[math.random(#spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        if
            mob:getLocalVar('nextAutomatonCalled') == 0 and
            callNextAutomaton(mob, player)
        then
            mob:setLocalVar('nextAutomatonCalled', 1)
        end
    end
end

return entity
