-----------------------------------
-- Area: Silver Sea Remnants
--  Mob: Ashu Talif Crew
--
-- Central room mobs (mob[1][3]) aggro with/without sneak
-- but will not attack until damaged (hpemde behavior)
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

local function isCentralRoomMob(mobID)
    return mobID >= ID.mob[1][3].mobs_start and mobID <= ID.mob[1][3].mobs_end
end

entity.onMobSpawn = function(mob)
    if isCentralRoomMob(mob:getID()) then
        mob:setMod(xi.mod.HPP, -90)
        mob:updateHealth()
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobMod(xi.mobMod.NO_REST, 1)
    end
end

entity.onMobRoam = function(mob)
    if isCentralRoomMob(mob:getID()) then
        if mob:getHP() == mob:getMaxHP() then
            mob:setLocalVar('damaged', 0)
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMagicCastingEnabled(false)
        end
    end
end

entity.onMobFight = function(mob, target)
    if isCentralRoomMob(mob:getID()) then
        if
            mob:getHP() < mob:getMaxHP() and
            mob:getLocalVar('damaged') == 0
        then
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setLocalVar('damaged', 1)
        end
    end
end

local function addRandomDrops(player, mob, pool, count, bonusChance)
    for i = 1, count do
        player:addTreasure(pool[math.random(1, #pool)], mob)
    end

    if bonusChance and math.random() < bonusChance then
        player:addTreasure(pool[math.random(1, #pool)], mob)
    end
end

local function getDropSet(dropTable)
    if #dropTable == 1 then
        return dropTable[1]
    end

    return dropTable[math.random(#dropTable)]
end

entity.onMobDeath = function(mob, player, optParams)
    if not optParams.isKiller then
        return
    end

    local mobID      = mob:getID()
    local instance   = mob:getInstance()
    local prog       = instance:getProgress()
    local hammerblow = ID.mob[1][2].hammerblow
    local cells      = ID.drops[3].CELLS

    -- Floor 1 - E Path
    if
        mobID >= ID.mob[1][1].mobs_start and
        mobID <= ID.mob[1][1].mobs_end
    then
        local offset  = ID.mob[1][1].mobs_end - mobID
        local dropSet = ID.drops[1][offset] and getDropSet(ID.drops[1][offset])

        if dropSet then
            for _, v in ipairs(dropSet) do
                player:addTreasure(v, mob)
            end
        else
            addRandomDrops(player, mob, cells, 3, 45)
        end

        -- xi.salvage.spawnTempChest(mob, {})

    -- Floor 1 - W Path
    elseif
        mobID >= ID.mob[1][2].mobs_start and
        mobID <= ID.mob[1][2].mobs_end
    then
        if mobID >= (hammerblow - 6) and mobID < hammerblow then -- "The 6"
            local offset  = hammerblow - mobID
            local dropSet = getDropSet(ID.drops[2][offset])

            if dropSet then
                for _, v in ipairs(dropSet) do
                    player:addTreasure(v, mob)
                end
            end

            instance:setProgress(prog + 1)
        else
            addRandomDrops(player, mob, cells, 3, 45)
        end

        -- xi.salvage.spawnTempChest(mob, {})

    -- Floor 1 Central Room
    elseif isCentralRoomMob(mobID) then
        addRandomDrops(player, mob, cells, 0, 45)
        -- xi.salvage.spawnTempChest(mob, {})

    -- Floor 2 (placeholder until floor 2 mob IDs are in IDs.lua)
    -- elseif
    --     mobID >= ID.mob[2][1].mobs_start and
    --     mobID <= ID.mob[2][1].mobs_end
    -- then
    --     addRandomDrops(player, mob, cells, 3, 45)
    --     xi.salvage.spawnTempChest(mob, {})
    end
end

return entity
