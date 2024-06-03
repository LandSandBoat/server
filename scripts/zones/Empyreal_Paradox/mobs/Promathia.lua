-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Promathia
-- Note: Phase 1
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 75)
    mob:addMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobEngage = function(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for _, v in pairs(bcnmAllies) do
        if v:getName() == 'Prishe' then
            if not v:getTarget() then
                v:entityAnimationPacket('prov')
                v:showText(v, ID.text.PRISHE_TEXT)
                v:setLocalVar('ready', mob:getID())
            end
        else
            v:addEnmity(mob, 0, 1)
            v:updateEnmity(mob)
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 3 and not mob:hasStatusEffect(xi.effect.STUN) then
        mob:setAnimationSub(0)
        mob:stun(1500)
    end

    local bcnmAllies = mob:getBattlefield():getAllies()
    for _, v in pairs(bcnmAllies) do
        if not v:getTarget() then
            v:addEnmity(mob, 0, 1)
            v:updateEnmity(mob)
        end
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 219 then
        spell:setMPCost(1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
