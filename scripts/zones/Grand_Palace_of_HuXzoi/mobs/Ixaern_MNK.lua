-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local entity = {}

local bracerMode = function(mob, qnAern1, qnAern2)
    local mobID = mob:getID()
    mob:useMobAbility(690) -- Hundred Fists
    if qnAern1:isAlive() then qnAern1:useMobAbility(692) end -- Chainspell
    if qnAern2:isAlive() then qnAern2:useMobAbility(689) end -- Benediction
    mob:addMod(xi.mod.ATT, 200)

    for i = mobID+1, mobID+2 do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            pet:AnimationSub(2)
            pet:addMod(xi.mod.ATT, 200)
            pet:setMod(xi.mod.DELAY, 2100)
        end
    end
    -- slightly delay adding local var to avoid adding bracers to Ix'Mnk while Hundred Fists is still active.
    mob:timer(3000, function(mobArg)
        mobArg:setLocalVar("enableBracers", 1)
    end)
end

entity.onMobSpawn = function(mob)
    -- adjust drops based on number of HQ Aern Organs traded to QM
    local qm = GetNPCByID(ID.npc.QM_IXAERN_MNK)
    local chance = qm:getLocalVar("[SEA]IxAern_DropRate")
    if math.random(0, 3) > 0 then
        SetDropRate(2845, xi.items.DEED_OF_PLACIDITY, chance * 10) -- Deed Of Placidity
        SetDropRate(2845, xi.items.VICE_OF_ANTIPATHY, 0)
    else
        SetDropRate(2845, xi.items.DEED_OF_PLACIDITY, 0)
        SetDropRate(2845, xi.items.VICE_OF_ANTIPATHY, chance * 10) -- Vice of Antipathy
    end
    qm:setLocalVar("[SEA]IxAern_DropRate", 0)

    mob:setAnimationSub(1) -- Reset the subanim - otherwise it will respawn with bracers on. Note that Aerns are never actually supposed to be in subanim 0.
    mob:setLocalVar("enableBracers", 0)
end

entity.onMobFight = function(mob, target)
    -- The mob gains a huge boost when it 2hours to attack speed and attack.
    -- It forces the minions to 2hour as well. Wiki says 50% but all videos show 60%.
    local qnAern1 = GetMobByID(ID.mob.IXAERN_MNK +1)
    local qnAern2 = GetMobByID(ID.mob.IXAERN_MNK +2)

    if mob:getLocalVar("BracerMode") == 0 then
        if
            mob:getHPP() < 60 or
            qnAern1:isAlive() and qnAern1:getHPP() < 60 or
            qnAern2:isAlive() and qnAern2:getHPP() < 60
        then -- If any of the three mobs gets below 60% then all three gain bracelets
            mob:setLocalVar("BracerMode", 1)
            bracerMode(mob, qnAern1, qnAern2)
        end
    end
    -- Ix'Mnk will not visually add Bracers while under the effect of Hundred Fists
    if not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS) and mob:getLocalVar("enableBracers") == 1 then
        mob:AnimationSub(2) -- Bracers
        mob:setMod(xi.mod.DELAY, 1700)
    else
        mob:setMod(xi.mod.DELAY, 0)
    end
end

entity.onMobEngaged = function(mob, target)
    for i = 1, 2 do -- pets reaggro if attacked from completely idle
        local minion = GetMobByID(mob:getID() + i)
        minion:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    local qm = GetNPCByID(ID.npc.QM_IXAERN_MNK)
    if (math.random(0, 1) == 1) then
        qm:setPos(380, 0, 540, 0) -- G-7
    else
        qm:setPos(460, 0, 540, 0) -- I-7
    end
    qm:updateNPCHideTime(xi.settings.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
