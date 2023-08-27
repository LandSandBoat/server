-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Promathia
-- Note: Phase 1
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local percents = { 90, 80, 70, 60, 50, 40, 30, 20, 10 }

local raceToChains =
{
    [ xi.race.HUME_M   ] = { 1491 },
    [ xi.race.HUME_F   ] = { 1491 },
    [ xi.race.ELVAAN_M ] = { 1492 },
    [ xi.race.ELVAAN_F ] = { 1492 },
    [ xi.race.TARU_M   ] = { 1493 },
    [ xi.race.TARU_F   ] = { 1493 },
    [ xi.race.MITHRA   ] = { 1494 },
    [ xi.race.GALKA    ] = { 1495 },
}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 75)
    mob:addMod(xi.mod.UFASTCAST, 50)
    mob:addMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:addMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobEngaged = function(mob, target)
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

    mob:setLocalVar("spellWait", os.time() + 50)
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 3 and not mob:hasStatusEffect(xi.effect.STUN) then
        mob:setAnimationSub(0)
        mob:stun(1500)
    end

    -- Engage Prishe and Selh'teus
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if not v:getTarget() then
            v:addEnmity(mob, 0, 1)
        end
    end

    -- Uses a Chains TP move every 10% health
    local chainsTrigger = mob:getLocalVar("chainsTrigger")
    local chainsUsed = mob:getLocalVar("chainsUsed")
    for i = 1, #percents do
        if mob:getHPP() < percents[i] and chainsTrigger < i then
            mob:setLocalVar("chainsTrigger", chainsTrigger + 1)
        end
    end

    if chainsUsed < chainsTrigger and mob:canUseAbilities() then
        local chains = {}
        local players = mob:getBattlefield():getPlayers()

        -- Create table of usable Chains TP moves
        for _, member in pairs(players) do
            local trigger = 0
            local race = member:getRace()
            for _, v in pairs(chains) do
                if v == raceToChains[race] then
                    trigger = 1
                end
            end

            if trigger == 0 then
                table.insert(chains, raceToChains[race])
            end
        end

        local move = math.random(1, #chains)
        mob:setLocalVar("mobTP", mob:getTP())
        mob:setLocalVar("tpMessage", 0)
        mob:useMobAbility(chains[move][1])
        mob:setLocalVar("chainsUsed", chainsUsed + 1)
    end

    -- Uses Comet every minute
    local spellWait = mob:getLocalVar("spellWait")
    if os.time() > spellWait and mob:canUseAbilities() then
        mob:castSpell(219, target)
        mob:setLocalVar("spellWait", os.time() + 66)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 219 then
        spell:setMPCost(1)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local mobTP = mob:getLocalVar("mobTP")
    local tpMessage = mob:getLocalVar("tpMessage")
    local tpMoves =
    {
        { 1491, 0 },
        { 1492, 1 },
        { 1493, 2 },
        { 1494, 3 },
        { 1495, 4 },
    }

    for _, tp in pairs(tpMoves) do
        if skill:getID() == tp[1] then
            if tpMessage == 0 then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + tp[2])
                mob:setLocalVar("tpMessage", 1)
            end

            mob:setTP(mobTP)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local battlefield = mob:getBattlefield()
    if player then
        player:startEvent(32004, battlefield:getArea())
    else
        local players = battlefield:getPlayers()
        for _, member in pairs(players) do
            member:startEvent(32004, battlefield:getArea())
        end
    end

    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if not v:getTarget() then
            v:clearEnmity(mob)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, target)
    if csid == 32004 then
        DespawnMob(target:getID())
        local mob = SpawnMob(target:getID() + 1)
        local bcnmAllies = mob:getBattlefield():getAllies()
        for i, v in pairs(bcnmAllies) do
            -- reset local vars so prise stars by waiting and can use 2hr again and such
            v:resetLocalVars()
            -- only reset Prishe position if she is alive at end of first phase
            if v:isAlive() then
                v:disengage()
                local spawn = v:getSpawnPos()
                v:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
            end

            -- TODO: figure out how to make Prishe start fighting right away when she dies in first phase
            -- and is raised in second phase before engaging 2nd phase Promathia
        end
    end
end

return entity
