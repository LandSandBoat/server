-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Kirin
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.DEF, 120)
    mob:addMod(xi.mod.EVA, 100)
    mob:setMod(xi.mod.REGAIN, 1000)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.WIND_MEVA, -64) -- Todo: Move to mob_resists.sql
    mob:setMod(xi.mod.SILENCERES, 35)
    mob:setMod(xi.mod.STUNRES, 35)
    mob:setMod(xi.mod.BINDRES, 35)
    mob:setMod(xi.mod.GRAVITYRES, 35)
    mob:setLocalVar("numAdds", 1)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngaged = function(mob)
    mob:timer(2000, function(mobArg)
        mob:messageText(mob, ID.text.KIRIN_OFFSET)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    -- spawn gods
    local numAdds = mob:getLocalVar("numAdds")
    if mob:getBattleTime() / 180 == numAdds then
        local godsRemaining = {}
        for i = 1, 4 do
            if mob:getLocalVar("add"..i) == 0 then
                table.insert(godsRemaining, i)
            end
        end

        if #godsRemaining > 0 and mob:getLocalVar("summoning") == 0 then
            local g = godsRemaining[math.random(#godsRemaining)]
            local god = GetMobByID(ID.mob.KIRIN + g)
            mob:setLocalVar("summoning", 1)
            mob:entityAnimationPacket("casm")
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)

            mob:timer(5000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:entityAnimationPacket("shsm")
                    god:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                    god:spawn()

                    if mobArg:getTarget() ~= nil then
                        god:updateEnmity(target)
                    end

                    mobArg:setLocalVar("add"..g, 1)
                    mobArg:setLocalVar("numAdds", numAdds + 1)
                    mobArg:setLocalVar("summoning", 0)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setMobAbilityEnabled(true)
                end
            end)
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
        GetMobByID(i):setHP(0)
    end
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        DespawnMob(i)
    end

    GetNPCByID(ID.npc.KIRIN_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
