-----------------------------------
-- Area: Bibiki Bay
--   NM: Dalham
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.WATER_ABSORB, 100)
end

function onMobFight(mob, target)
    -- "Increases swings per attack round as its HP lowers. At 15-20% swings like Charybdis giving the illusion of Hundred Fists."
    local swings = 1 + math.floor((100 - mob:getHPP()) / 18)
    mob:setMobMod(tpz.mobMod.MULTI_HIT, swings)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Dalham_KILL") == 0) then
        player:setCharVar("COP_Dalham_KILL", 1)
    end
end
