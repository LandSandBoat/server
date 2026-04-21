-----------------------------------
-- Area: Riverne Site #A01
-- Name: Ouryu Cometh
-- !pos 187.112 -0.5 346.341 30
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.RIVERNE_SITE_A01,
    battlefieldId = xi.battlefield.id.OURYU_COMETH,
    maxPlayers    = 18,
    levelCap      = 99,
    timeLimit     = utils.minutes(60),
    index         = 0,
    area          = 1,
    entryNpc      = 'Unstable_Displacement',
    exitNpc       = 'Spatial_Displacement_BC',
    requiredItems = { xi.item.CLOUD_EVOKER }
})

local function healCharacter(player)
    -- Handle player.
    if not player:isAlive() then
        return
    end

    player:setHP(player:getMaxHP())
    player:setMP(player:getMaxMP())
    player:setTP(0)

    -- Handle player's pet.
    local pet = player:getPet()
    if pet then
        pet:setHP(pet:getMaxHP())
        pet:setMP(pet:getMaxMP())
        pet:setTP(0)
    end
end

-- Players are healed when entering the battlefield
function content:battlefieldEntry(player, battlefield)
    healCharacter(player)
end

content.groups =
{
    {
        mobs           = { 'Ouryu' },
    },

    {
        mobs    = { 'Water_Elemental', 'Earth_Elemental', 'Ziryu' },
        spawned = false,
    }
}

return content:register()
