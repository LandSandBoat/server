-----------------------------------
-- Area: Sealion's Den
--  Mob: Makki-Chebukki
-----------------------------------
mixins = { require('scripts/mixins/warriors_path_taru') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 30) -- Makki Chebukki uses ranged attack every 30 seconds
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:addMod(xi.mod.UDMGPHYS, -100)
    mob:addMod(xi.mod.UDMGMAGIC, -100)
    mob:addMod(xi.mod.UDMGRANGE, -100)
    mob:addMod(xi.mod.UDMGBREATH, -100)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('makki', 1)
end

entity.onMobEngaged = function(mob, target)
    mob:entityAnimationPacket('ouen') -- each taru will use this animation at the start of the fight
    mob:setMobMod(xi.mobMod.NO_LINK, 0)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setAnimationSub(1)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    local battletime = mob:getBattleTime()
    local changetime = mob:getLocalVar('changetime')
    if battlefield:getLocalVar('fireworks') == 1 then
        if battletime - changetime >= 3 then
            mob:setMagicCastingEnabled(false)
            mob:entityAnimationPacket('ffr2')
            mob:setAnimationSub(2)
            mob:setLocalVar('changetime', mob:getBattleTime())
        end
    end
end

entity.onMobDisengage = function(mob, target)
    mob:setAnimationSub(2) -- laughing pose
end

return entity
