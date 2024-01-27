-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Kirin
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.WIND_MEVA, -64) -- Todo: Move to mob_resists.sql
    mob:setMod(xi.mod.SILENCE_MEVA, 35)
    mob:setMod(xi.mod.STUN_MEVA, 35)
    mob:setMod(xi.mod.BIND_MEVA, 35)
    mob:setMod(xi.mod.GRAVITY_MEVA, 35)
    mob:addStatusEffect(xi.effect.REGEN, 50, 3, 0)
    mob:setLocalVar('numAdds', 1)
end

entity.onMobFight = function(mob, target)
    -- spawn gods
    local numAdds = mob:getLocalVar('numAdds')
    if mob:getBattleTime() / 180 == numAdds then
        local godsRemaining = {}
        for i = 1, 4 do
            if mob:getLocalVar('add'..i) == 0 then
                table.insert(godsRemaining, i)
            end
        end

        if #godsRemaining > 0 then
            local g   = godsRemaining[math.random(1, #godsRemaining)]
            local god = SpawnMob(ID.mob.KIRIN + g)
            god:updateEnmity(target)
            god:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
            mob:setLocalVar('add'..g, 1)
            mob:setLocalVar('numAdds', numAdds + 1)
        end
    end

    -- ensure all spawned pets are doing stuff
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        local god = GetMobByID(i)
        if god:getCurrentAction() == xi.act.ROAMING then
            god:updateEnmity(target)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KIRIN_CAPTIVATOR)
    player:showText(mob, ID.text.KIRIN_OFFSET + 1)
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        DespawnMob(i)
    end
end

return entity
