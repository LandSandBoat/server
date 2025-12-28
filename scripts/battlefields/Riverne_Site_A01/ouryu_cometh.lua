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
        mobs           = { 'Ouryu' },
        superlinkGroup = 1,

        -- This death handler needs to be defined locally since there is no armoury crate.
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobs           = { 'Ziryu' },
        superlinkGroup = 1,
        spawned        = false,
    },

    {
        mobs    = { 'Water_Elemental', 'Earth_Elemental' },
    }
}

return content:register()
