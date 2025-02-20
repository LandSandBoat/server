-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG's Wynav
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('hpTrigger', math.random(10, 75))
end

entity.onMobFight = function(mob, target)
    local hpTrigger = mob:getLocalVar('hpTrigger')
    if mob:getLocalVar('SoulVoice') == 0 and mob:getHPP() <= hpTrigger then
        mob:setLocalVar('SoulVoice', 1)
        mob:useMobAbility(696) -- Soul Voice
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellList =
    {
        [1] = 382,
        [2] = 376,
        [3] = 372,
        [4] = 392,
        [5] = 397,
        [6] = 400,
        [7] = 422,
        [8] = 462,
        [9] = 466 -- Virelai (charm)
    }
    if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        return spellList[math.random(1, 9)] -- Virelai possible.
    else
        return spellList[math.random(1, 8)] -- No Virelai!
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('repop', mob:getBattleTime()) -- This get erased on respawn automatic.
end

return entity
