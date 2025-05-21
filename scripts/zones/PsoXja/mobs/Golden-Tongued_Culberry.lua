-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 19800)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
    mob:setMod(xi.mod.FASTCAST, 50)
    mob:setMod(xi.mod.MDEF, 33)
    mob:setMod(xi.mod.SPELLINTERRUPT, 2)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_CULBERRY', function(mobArg, loot)
        loot:addItemFixed(xi.item.UGGALEPIH_PENDANT, mob:getLocalVar('DropRate'))
    end)
end

entity.onMobFight = function(mob, target)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    if target:isPet() then
        mob:setMod(xi.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(xi.mod.FASTCAST, 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
