-----------------------------------
-- Let Sleeping Dogs Die
-- Qu'Bia Arena BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.LET_SLEEPING_DOGS_DIE,
    maxPlayers    = 6,
    levelCap      = 30,
    timeLimit     = utils.minutes(30),
    index         = 10,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.SKY_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Capelthwaite', 'Freybug', 'Rongeur_Dos', 'Guytrash' })

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    -- If we have won, stop everything.
    if battlefield:getLocalVar('battlefieldWon') ~= 0 then
        return
    end

    local baseID       = qubiaID.mob.CAPELTHWAITE + (battlefield:getArea() - 1) * 5
    local respawnOffset = battlefield:getLocalVar('respawnOffset')
    local deadCount = 0

    -- Check if any dogs are dead.
    if respawnOffset == 0 then
        for i = 0, 3 do
            local mobId = baseID + i
            local dog   = GetMobByID(mobId)
            if dog and not dog:isAlive() then
                local deathTime = dog:getLocalVar('deathTime')
                -- After 30s queue respawn.
                if deathTime > 0 and (GetSystemTime() - deathTime) >= 30 then

                    -- Store position for respawn. We store them multiplied by 100 to avoid float issues.
                    local xPos = dog:getXPos()
                    local yPos = dog:getYPos()
                    local zPos = dog:getZPos()
                    local rPos = dog:getRotPos()

                    battlefield:setLocalVar('xPos', math.floor(math.abs(xPos) * 100))
                    battlefield:setLocalVar('yPos', math.floor(math.abs(yPos) * 100))
                    battlefield:setLocalVar('zPos', math.floor(math.abs(zPos) * 100))
                    battlefield:setLocalVar('rPos', math.floor(rPos * 100))

                    battlefield:setLocalVar('xPosSign', (xPos < 0) and 1 or 0)
                    battlefield:setLocalVar('yPosSign', (yPos < 0) and 1 or 0)
                    battlefield:setLocalVar('zPosSign', (zPos < 0) and 1 or 0)

                    battlefield:setLocalVar('respawnOffset', i + 1)

                    -- Despawn the dog.
                    dog:setLocalVar('deathTime', 0)
                    dog:setBehavior(xi.behavior.NONE)
                    DespawnMob(mobId)
                    return
                end

                if deathTime > 0 then
                    deadCount = deadCount + 1
                end
            end
        end

        -- If all four dogs are dead, cleanup and end the battle.
        if deadCount == 4 then
            for i = 0, 3 do
                local id  = baseID + i
                local dog = GetMobByID(id)
                if dog then
                    dog:setBehavior(xi.behavior.NONE)
                    DespawnMob(id)
                end
            end

            battlefield:setLocalVar('battlefieldWon', 1)
            content:handleAllMonstersDefeated(battlefield)
        end

        return
    end

    -- Handle respawning dogs.
    local mobId     = baseID + respawnOffset - 1
    local dogEntity = GetMobByID(mobId)

    if dogEntity and not dogEntity:isSpawned() then
        local xPos = battlefield:getLocalVar('xPos') / 100 * (1 - 2 * battlefield:getLocalVar('xPosSign'))
        local yPos = battlefield:getLocalVar('yPos') / 100 * (1 - 2 * battlefield:getLocalVar('yPosSign'))
        local zPos = battlefield:getLocalVar('zPos') / 100 * (1 - 2 * battlefield:getLocalVar('zPosSign'))
        local rPos = battlefield:getLocalVar('rPos') / 100

        -- Spawn the dog, set its position and update enmity.
        SpawnMob(mobId)
        dogEntity:setPos(xPos, yPos, zPos, rPos)

        -- Check if any other dogs have a target and update the spawned dog to that target.
        for i = 0, 3 do
            local otherDogId = baseID + i
            if otherDogId ~= mobId then
                local otherDog = GetMobByID(otherDogId)
                if otherDog and otherDog:isAlive() then
                    local target = otherDog:getTarget()
                    if target then
                        dogEntity:updateEnmity(target)
                        break
                    end
                end
            end
        end

        -- Reset Variables.
        battlefield:setLocalVar('xPos', 0)
        battlefield:setLocalVar('yPos', 0)
        battlefield:setLocalVar('zPos', 0)
        battlefield:setLocalVar('rPos', 0)
        battlefield:setLocalVar('xPosSign', 0)
        battlefield:setLocalVar('yPosSign', 0)
        battlefield:setLocalVar('zPosSign', 0)
        battlefield:setLocalVar('respawnOffset', 0)
    end
end

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 1000, amount = 4000 },
    },

    {
        { itemId = xi.item.WOLF_HIDE,              weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.SINGERS_SHIELD,         weight = 250 },
        { itemId = xi.item.WARLOCKS_SHIELD,        weight = 250 },
        { itemId = xi.item.MAGICIANS_SHIELD,       weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.ASHIGARU_MANTLE,        weight = 250 },
        { itemId = xi.item.WYVERN_MANTLE,          weight = 250 },
        { itemId = xi.item.KILLER_MANTLE,          weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 800 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  20 },
        { itemId = xi.item.IRON_INGOT,             weight =  20 },
        { itemId = xi.item.STEEL_INGOT,            weight =  20 },
        { itemId = xi.item.SILVER_INGOT,           weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =  20 },
        { itemId = xi.item.ELM_LOG,                weight =  20 },
    },

    {
        { itemId = xi.item.REVIVAL_TREE_ROOT,      weight = 250 },
        { itemId = xi.item.PETRIFIED_LOG,          weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.SCROLL_OF_ABSORB_AGI,   weight =  91 },
        { itemId = xi.item.SCROLL_OF_ABSORB_INT,   weight =  91 },
        { itemId = xi.item.SCROLL_OF_ABSORB_VIT,   weight =  91 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight =  92 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight =  45 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight =  45 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight =  45 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 100 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight = 300 },
        { itemId = xi.item.MANNEQUIN_BODY,         weight = 300 },
        { itemId = xi.item.MANNEQUIN_HANDS,        weight = 300 },
    },
}

return content:register()
