-----------------------------------
-- Area: Sealion's Den
--  Mob: Cherukiki
-----------------------------------
local ID = zones[xi.zone.SEALIONS_DEN]
mixins = { require('scripts/mixins/warriors_path_taru') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Leaving these mods here for visual: Tarus can't take damage, don't move, and have scripted fight interactions
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60) -- cherukiki casts magic aproximately every 25 seconds
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:addMod(xi.mod.UDMGPHYS, -100)
    mob:addMod(xi.mod.UDMGMAGIC, -100)
    mob:addMod(xi.mod.UDMGRANGE, -100)
    mob:addMod(xi.mod.UDMGBREATH, -100)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('cheru', 1)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngaged = function(mob, target)
    mob:entityAnimationPacket('ouen') -- each taru will use this animation at the start of the fight
    mob:setMobMod(xi.mobMod.NO_LINK, 0)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMagicCastingEnabled(true)
    mob:setAnimationSub(1)
end

entity.onMobFight = function(mob, target)
    local bfID = mob:getBattlefield():getArea()
    local battlefield = mob:getBattlefield()
    local changetime = mob:getLocalVar('changetime')
    local battletime = mob:getBattleTime()
    if battlefield:getLocalVar('fireworks') == 1 then
        mob:setMagicCastingEnabled(false)
        if battletime - changetime >= 3 then
            mob:entityAnimationPacket('ffr2')
            mob:setAnimationSub(2)
            mob:setLocalVar('changetime', mob:getBattleTime())
        end
    end

    local tenzenId = GetMobByID(ID.aWarriorsPath.TENZEN_ID + (bfID - 1))
    if
        tenzenId:getHPP() <= 70 and
        battlefield:getLocalVar('fireworks') == 0
    then
        if mob:getLocalVar('cooldown') == 0 then
            mob:castSpell(4, tenzenId)
            mob:setLocalVar('cooldown', 70) -- every 30 seconds Cherukiki will cast Cure IV on tenzen
        end
    else
        mob:setLocalVar('cooldown', 70)
    end

    if mob:getLocalVar('cooldown') > 0 then
        mob:setLocalVar('cooldown', mob:getLocalVar('cooldown') - 1)
    end
end

entity.onMobDisengage = function(mob, target)
    mob:setAnimationSub(2) -- laughing pose
end

return entity
