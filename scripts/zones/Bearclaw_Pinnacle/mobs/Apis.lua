-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Apis
--  ENM: Holy Cow
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 35)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar('colorChange', os.time() + 60)
    mob:setLocalVar('currentColor', math.random(1, 3))
end

entity.onMobFight = function(mob, target)
    local indicies = { 1, 2, 3 }
    local currentColor = mob:getLocalVar('currentColor')
    local abilities = { 624, 625, 627 }

    if os.time() > mob:getLocalVar('colorChange') then
        mob:setLocalVar('colorChange', os.time() + math.random(60, 90))
        mob:setLocalVar('twohour_tp', mob:getTP())
        table.remove(indicies, currentColor)
        local index = indicies[math.random(#indicies)]
        mob:useMobAbility(abilities[index])
        mob:setLocalVar('currentColor', index)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 624 then -- blue: High ATK, double and triple attack. High magic immunity
        mob:setMod(xi.mod.DOUBLE_ATTACK, 35)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 35)
        mob:setMod(xi.mod.ATT, 2000)
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setMod(xi.mod.UDMGMAGIC, -9800)
        mob:setMod(xi.mod.UDMGPHYS, 0)
        mob:addTP(mob:getLocalVar('twohour_tp'))
        mob:setLocalVar('twohour_tp', 0)
    end

    if skill:getID() == 625 then -- yellow: Moderate ATK, takes lowered phys and magic damage
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
        mob:setMod(xi.mod.ATT, 1000)
        mob:setMod(xi.mod.UDMGRANGE, -3000)
        mob:setMod(xi.mod.UDMGMAGIC, 0)
        mob:setMod(xi.mod.UDMGPHYS, -3000)
        mob:addTP(mob:getLocalVar('twohour_tp'))
        mob:setLocalVar('twohour_tp', 0)
    end

    if skill:getID() == 627 then -- green: Low ATK, High physical immune.
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
        mob:setMod(xi.mod.ATT, 500)
        mob:setMod(xi.mod.UDMGRANGE, -9800)
        mob:setMod(xi.mod.UDMGMAGIC, 4000)
        mob:setMod(xi.mod.UDMGPHYS, -9800)
        mob:addTP(mob:getLocalVar('twohour_tp'))
        mob:setLocalVar('twohour_tp', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
