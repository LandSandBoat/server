-----------------------------------
-- Area: Riverne Site #B01
-- Name: The Wyrmking Descends
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_B01]
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
    requiredItems =
    {
        xi.item.MONARCHS_ORB,
        wearMessage = riverneID.text.TIME_LIMIT_FOR_THIS_BATTLE_IS + 2,
        wornMessage = riverneID.text.TIME_LIMIT_FOR_THIS_BATTLE_IS + 1,
    },
})

content:addEssentialMobs({ 'Bahamutv2' })

local function healCharacter(player)
    if player:isAlive() then
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)

        if player:getPet() ~= nil then
            local pet = player:getPet()
            pet:setHP(pet:getMaxHP())
            pet:setMP(pet:getMaxMP())
            pet:setTP(0)
        end
    end
end

-- players on healed on entry to the battlefield
function content:battlefieldEntry(player, battlefield)
    healCharacter(player)
end

content.groups =
{
    {
        mobIds =
        {
            riverneID.mob.BAHAMUTV2,
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
    {
        mobs = { 'Ouryu_Wyrmking' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Tiamat_Wyrmking' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Jormungand_Wyrmking' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Vrtra_Wyrmking' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Ziryu' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Water_Elemental' },
        superlink = true,
        spawned = false,
    },
    {
        mobs = { 'Earth_Elemental' },
        superlink = true,
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
