-- Area: Riverne Site #B01
-- Name: The Wyrmking Descends
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local content = Battlefield:new({
    zoneId        = xi.zone.RIVERNE_SITE_B01,
    battlefieldId = xi.battlefield.id.WYRMKING_DESCENDS,
    maxPlayers    = 18,
    levelCap      = 99,
    timeLimit     = utils.minutes(60),
    index         = 1,
    area          = 1,
    entryNpc      = 'Unstable_Displacement',
    exitNpc       = 'SD_BCNM_Exit',
    requiredItems = { xi.item.MONARCHS_ORB }
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
        mobs = { 'Bahamut_bv2' },

        superlink = true,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
    {
        mobs = { 'Ouryu_bv2' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Tiamat_bv2' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Jormungand_bv2' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Vrtra_bv2' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Ziryu' },
        superlink = false,
        spawned = false,
    },
    {
        mobs = { 'Water_Elemental' },
        superlink = false,
        spawned = false,
    },
    {
        mobs = { 'Earth_Elemental' },
        superlink = false,
        spawned = false,
    },
    {
        mobs = { 'Pey' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Iruci' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Airi' },
        superlink = true,
        spawned = false,
    },
}

return content:register()
