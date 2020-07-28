-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Promathia
-- Note: Phase 1
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 50)
    mob:addMod(tpz.mod.UFASTCAST, 50)
end

function onMobEngaged(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if v:getName() == "Prishe" then
            if not v:getTarget() then
                v:entityAnimationPacket("prov")
                v:showText(v, ID.text.PRISHE_TEXT)
                v:setLocalVar("ready", mob:getID())
            end
        else
            v:addEnmity(mob, 0, 1)
        end
    end
end

function onMobFight(mob, target)
    if mob:AnimationSub() == 3 and not mob:hasStatusEffect(tpz.effect.STUN) then
        mob:AnimationSub(0)
        mob:stun(1500)
    end

    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if not v:getTarget() then
            v:addEnmity(mob, 0, 1)
        end
    end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 219 then
        spell:setMPCost(1)
    end
end

function onMobDeath(mob, player, isKiller)
    local battlefield = mob:getBattlefield()
    if player then
        player:startEvent(32004, battlefield:getArea())
    else
        for _, member in pairs(battlefield:getPlayers()) do
            member:startEvent(32004, battlefield:getArea())
        end
    end
end

function onEventUpdate(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

function onEventFinish(player, csid, option, target)
    -- printf("finishCSID: %u", csid)

    if csid == 32004 then
        DespawnMob(target:getID())
        mob = SpawnMob(target:getID()+1)
        local bcnmAllies = mob:getBattlefield():getAllies()
        for i, v in pairs(bcnmAllies) do
            v:resetLocalVars()
            local spawn = v:getSpawnPos()
            v:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
        end
    end

end
