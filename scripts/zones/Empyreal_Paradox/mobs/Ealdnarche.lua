-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
require('scripts/globals/magic')

local entity = {}

local spellList =
{
    xi.magic.spell.FIRAGA_III,
    xi.magic.spell.BLIZZAGA_III,
    xi.magic.spell.AEROGA_III,
    xi.magic.spell.STONEGA_III,
    xi.magic.spell.THUNDAGA_III,
    xi.magic.spell.WATERGA_III,
    xi.magic.spell.SLEEPGA_II,
    xi.magic.spell.BINDGA,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:addMod(xi.mod.EVA, 50) -- Meant to be highly evasive.
    mob:addMod(xi.mod.REFRESH, 100)
    mob:addMod(xi.mod.UFASTCAST, 40)
    mob:setMod(xi.mod.MDEF, 305)
    mob:setMod(xi.mod.MATT, 30)
    mob:addMod(xi.mod.DEF, 200)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    if os.time() > mob:getLocalVar("[EALD]teleportTime") then
        mob:setLocalVar("[EALD]TP", mob:getTP())
        mob:useMobAbility(989) -- Warp Out
        mob:setLocalVar("[EALD]teleportTime", os.time() + 30)
    end

    if mob:checkDistance(target) >= 3 then -- Based on captures and videos Eald'narche casts immediately after teleport if out of melee range.
        if os.time() > mob:getLocalVar("[EALD]nextCast") then -- Should only cast once then go back to melee.
            local selectedSpell = math.random(1, #spellList)
            mob:setLocalVar("[EALD]nextCast", os.time() + 20) -- 20s generally is enough time to cast the spell and start closing the range.
            mob:castSpell(spellList[selectedSpell], target)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 988 or skill:getID() == 989 then
        mob:setTP(mob:getLocalVar("[EALD]TP"))
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
