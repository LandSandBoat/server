-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanneitsyt
-- BCNM: Grove Guardians
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMod(xi.mod.SILENCE_MEVA, 50) -- Using Silence MEVA here since Gravity was easy to land.
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 12)
end

-- Metsanneitsyt must be kept next to its' guardians. If it moves more than 10 yalms away from either guardian, it will gain a huge amount of Regain.
entity.onMobFight = function(mob, target)
    local queenID = mob:getID()
    local guardianOne = GetMobByID(queenID + 1)
    local guardianTwo = GetMobByID(queenID + 2)
    local awayFromGuardian = false

    if
        guardianOne and
        guardianOne:isAlive()
    then
        if mob:checkDistance(guardianOne) >= 10 then
            awayFromGuardian = true
        end
    end

    if
        guardianTwo and
        guardianTwo:isAlive()
    then
        if mob:checkDistance(guardianTwo) >= 10 then
            awayFromGuardian = true
        end
    end

    if awayFromGuardian then
        mob:setMod(xi.mod.REGAIN, 1000)
    else
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONEGA,  60 },
        [2] = { xi.magic.spell.ASPIR,    20 },
        [3] = { xi.magic.spell.STONE_II, 10 },
        [4] = { xi.magic.spell.DRAIN,    10 },
    }

    local randomRoll = math.random(1, 100)
    local weightSum  = 0
    for i = 1, #spellList do
        weightSum = weightSum + spellList[i][2]
        if randomRoll <= weightSum then
            return spellList[i][1]
        end
    end
end

return entity
