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
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.MDEF, 50);
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.EVA, 50) -- Meant to be highly evasive.
end

entity.onMobFight = function(mob, target)
    print(mob:getTP())
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

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
