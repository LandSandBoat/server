-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 60)
    mob:setMod(xi.mod.UDMGMAGIC, -1250)
    mob:setUnkillable(true)
    mob:setLocalVar('killable', 0)
    mob:setLocalVar('defaultAttack', mob:getMod(xi.mod.ATT))
end

entity.onMobFight = function(mob, target)
    local killable = mob:getLocalVar('killable')
    -- Gains significantly increased damage as HP decreases.
    local hp = mob:getHPP()
    local power = (100 - hp) * 5

    if
        mob:getHPP() == 1 and
        mob:getMod(xi.mod.UDMGPHYS) == 0 and
        killable == 0
    then
        mob:setMod(xi.mod.UDMGPHYS, -10000)
        mob:setMod(xi.mod.UDMGRANGE, -10000)
        mob:setMod(xi.mod.UDMGMAGIC, -10000)
        mob:setMod(xi.mod.UDMGBREATH, -10000)
    end

    mob:setMod(xi.mod.ATT, mob:getLocalVar('defaultAttack') + power)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, { chance = 30 })
end

entity.onSteal = function(player, target, ability, action)
    -- this is a hack, we can't add item directly here with proper messaging at the moment, and this is a mega edge case.
    -- one tick later the item should be landed in the players inventory
    -- set exdata to indicate the item can be transformed
    if math.random(1, 100) <= 10 then
        -- Check for inventory if the item exists (onSteal returning an item doesn't mean steal succeeds)
        player:timer(1, function(playerArg)
            local item = playerArg:findItem(xi.item.BUCCANEERS_KNIFE)

            if item then
                item:setExDataRaw({ [0] = 0x08 })
            end
        end)
    end

    return xi.item.BUCCANEERS_KNIFE
end

return entity
