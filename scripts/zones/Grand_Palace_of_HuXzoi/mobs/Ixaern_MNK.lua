-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local bracerMode = function(mob, qnAern1, qnAern2)
    -- Hundred Fists
    mob:useMobAbility(xi.jsa.HUNDRED_FISTS)
    mob:addMod(xi.mod.ATT, 200)
    -- captures show delay reduction from 280 -> 120
    -- note this is actual delay reduction with change in tp gained and imparted
    -- note lvl 83 mnk with martial arts vii
    mob:setMod(xi.mod.DELAY, 2600)

    if qnAern1 and qnAern1:isAlive() then
        qnAern1:setAnimationSub(2)
        qnAern1:addMod(xi.mod.ATT, 200)
        -- captures show delay reduction from 240 -> 120
        -- note this is actual delay reduction with change in tp gained and imparted
        qnAern1:setMod(xi.mod.DELAY, 2000)
    end

    if qnAern2 and qnAern2:isAlive() then
        qnAern2:setAnimationSub(2)
        qnAern2:addMod(xi.mod.ATT, 200)
        -- captures show delay reduction from 240 -> 120
        -- note this is actual delay reduction with change in tp gained and imparted
        qnAern2:setMod(xi.mod.DELAY, 2000)
    end

    -- slightly delay adding local var to avoid adding bracers to Ix'Mnk
    -- while Hundred Fists is still active.
    mob:timer(3000, function(mobArg)
        mobArg:setLocalVar('enableBracerAnimation', 1)
    end)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)

    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_IXAERN_MNK', function(mobArg, loot)
        local rate = mob:getLocalVar('[SEA]IxAern_DropRate')
        loot:addGroupFixed(rate,
        {
            { item = xi.item.DEED_OF_PLACIDITY, weight = 750 },
            { item = xi.item.VICE_OF_ANTIPATHY, weight = 250 },
        })
    end)
end

entity.onMobSpawn = function(mob)
    -- reset the subanim otherwise it will respawn with bracers on
    -- note that Aerns are never actually supposed to be in subanim 0
    mob:setAnimationSub(1)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('BracerMode') == 0 then
        local IxaernID = mob:getID()
        local qnAern1 = GetMobByID(IxaernID + 1)
        local qnAern2 = GetMobByID(IxaernID + 2)

        -- if any of the three mobs gets below 60% then all three go to bracer mode
        if
            mob:getHPP() < 60 or
            (qnAern1 and qnAern1:isAlive() and qnAern1:getHPP() < 60) or
            (qnAern2 and qnAern2:isAlive() and qnAern2:getHPP() < 60)
        then
            mob:setLocalVar('BracerMode', 1)
            bracerMode(mob, qnAern1, qnAern2)
        end
    end

    -- only give bracer animation after Hundred Fists
    if
        not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS) and
        mob:getLocalVar('enableBracerAnimation') == 1
    then
        mob:setAnimationSub(2) -- Bracers
    end
end

entity.onMobEngage = function(mob, target)
    -- Qn'Aerns reaggro if Ix'aern attacked while idle
    for i = 1, 2 do
        local qnAernID = mob:getID() + i
        local qnAern = GetMobByID(qnAernID)
        if
            qnAern and
            qnAern:isAlive() and
            qnAern:getCurrentAction() == xi.act.ROAMING
        then
            qnAern:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Qn'Aerns despawn if Ix'aern is killed
    for i = 1, 2 do
        local qnAernID = mob:getID() + i
        local qnAern = GetMobByID(qnAernID)
        if
            qnAern and
            qnAern:isAlive()
        then
            DespawnMob(qnAernID)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- Qn'Aerns despawn if Ix'aern just despawns
    for i = 1, 2 do
        local qnAernID = mob:getID() + i
        local qnAern = GetMobByID(qnAernID)
        if
            qnAern and
            qnAern:isAlive()
        then
            DespawnMob(qnAernID)
        end
    end

    local qm = GetNPCByID(ID.npc.QM_IXAERN_MNK)
    if qm then
        if math.random(0, 1) == 1 then
            qm:setPos(380, 0, 540, 0) -- G-7
        else
            qm:setPos(460, 0, 540, 0) -- I-7
        end

        qm:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
