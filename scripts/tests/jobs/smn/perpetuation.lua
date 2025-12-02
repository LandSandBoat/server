---@param player CClientEntityPair
---@param cost integer
local function verifyPerpetuationCost(player, cost)
    player:setMP(player:getMaxMP())
    local petName = player:getPetName() or 'avatar'
    for i = 1, 5 do
        local startMP = player:getMP()
        xi.test.world:tick(xi.tick.EFFECT)
        local lostMP = startMP - player:getMP()
        assert(
            lostMP == cost,
            string.format('Expected to lose %u with %s summoned but lost %u.',
                cost, petName, lostMP)
        )
    end
end

local specialBaseCost =
{
    [xi.petId.CARBUNCLE] = 9,
    [xi.petId.FENRIR] = 11,
}

describe('Avatar perpetuation', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.SMN, level = 75 })
        player:setMod(xi.mod.REFRESH, 0)
        xi.test.world:tick()
    end)

    it('has normal cost without matching day or weather', function()
        -- Verify no gain or loss of MP without avatar
        verifyPerpetuationCost(player, 0)
        -- Verify losing MP according to avatar perpetuation
        xi.test.world:setVanaDay(xi.day.DARKSDAY)
        player:spawnPet(xi.petId.GARUDA)
        verifyPerpetuationCost(player, 13)
        player:despawnPet()
        player:spawnPet(xi.petId.CARBUNCLE)
        verifyPerpetuationCost(player, 9)
    end)

    it('is reduced by elemental staves', function()
        local staves =
        {
            {
                itemId    = xi.item.FIRE_STAFF,
                reduction = xi.petId.IFRIT,
                increase  = xi.petId.SHIVA,
            },
            {
                itemId    = xi.item.EARTH_STAFF,
                reduction = xi.petId.TITAN,
                increase  = xi.petId.RAMUH,
            },
            {
                itemId    = xi.item.WATER_STAFF,
                reduction = xi.petId.LEVIATHAN,
                increase  = xi.petId.IFRIT,
            },
            {
                itemId    = xi.item.WIND_STAFF,
                reduction = xi.petId.GARUDA,
                increase  = xi.petId.TITAN,
            },
            {
                itemId    = xi.item.ICE_STAFF,
                reduction = xi.petId.SHIVA,
                increase  = xi.petId.GARUDA,
            },
            {
                itemId    = xi.item.THUNDER_STAFF,
                reduction = xi.petId.RAMUH,
                increase  = xi.petId.LEVIATHAN,
            },
            {
                itemId    = xi.item.LIGHT_STAFF,
                reduction = xi.petId.CARBUNCLE,
                increase  = xi.petId.FENRIR,
            },
            {
                itemId    = xi.item.DARK_STAFF,
                reduction = xi.petId.FENRIR,
                increase  = xi.petId.CARBUNCLE,
            },
        }
        -- Run through each staff and verify
        for _, staff in ipairs(staves) do
            player:addItem(staff.itemId)
            player:equipItem(staff.itemId)
            -- Verify the staff increases cost for same element
            player:despawnPet()
            player:spawnPet(staff.reduction)
            verifyPerpetuationCost(player, (specialBaseCost[staff.reduction] or 13) - 2)
            -- Verify the staff increases cost for opposite element
            player:despawnPet()
            player:spawnPet(staff.increase)
            verifyPerpetuationCost(player, (specialBaseCost[staff.increase] or 13) + 2)
        end
    end)

    it('is reduced on matching days with AF2 Body', function()
        player:addItem(xi.item.SUMMONERS_DOUBLET)
        player:equipItem(xi.item.SUMMONERS_DOUBLET)
        -- Test with avatar matching each day, and one that doesn't
        local cases =
        {
            {
                day         = xi.day.FIRESDAY,
                matching    = xi.petId.IFRIT,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.EARTHSDAY,
                matching    = xi.petId.TITAN,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.WATERSDAY,
                matching    = xi.petId.LEVIATHAN,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.WINDSDAY,
                matching    = xi.petId.GARUDA,
                notMatching = xi.petId.IFRIT,
            },
            {
                day         = xi.day.ICEDAY,
                matching    = xi.petId.SHIVA,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.LIGHTNINGDAY,
                matching    = xi.petId.RAMUH,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.LIGHTSDAY,
                matching    = xi.petId.CARBUNCLE,
                notMatching = xi.petId.GARUDA,
            },
            {
                day         = xi.day.DARKSDAY,
                matching    = xi.petId.FENRIR,
                notMatching = xi.petId.GARUDA,
            },
        }
        for _, case in ipairs(cases) do
            xi.test.world:setVanaDay(case.day)
            player:despawnPet()
            -- Reduced cost with avatar matching day
            player:spawnPet(case.matching)
            local cost = (specialBaseCost[case.matching] or 13) - 3
            verifyPerpetuationCost(player, cost)
            player:despawnPet()
            -- Regular cost with avatar not matching day
            player:spawnPet(case.notMatching)
            cost = specialBaseCost[case.notMatching] or 13
            verifyPerpetuationCost(player, cost)
        end
    end)

    it('is reduced on matching weather with AF2 Head', function()
        -- Add item that gives reduction for avatar matching weather
        player:addItem(xi.item.SUMMONERS_HORN)
        player:equipItem(xi.item.SUMMONERS_HORN)
        -- Test with avatar matching each day, and one that doesn't
        local cases =
        {
            {
                weather     = xi.weather.HEAT_WAVE,
                matching    = xi.petId.IFRIT,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.DUST_STORM,
                matching    = xi.petId.TITAN,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.RAIN,
                matching    = xi.petId.LEVIATHAN,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.GALES,
                matching    = xi.petId.GARUDA,
                notMatching = xi.petId.IFRIT,
            },
            {
                weather     = xi.weather.SNOW,
                matching    = xi.petId.SHIVA,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.THUNDER,
                matching    = xi.petId.RAMUH,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.AURORAS,
                matching    = xi.petId.CARBUNCLE,
                notMatching = xi.petId.GARUDA,
            },
            {
                weather     = xi.weather.DARKNESS,
                matching    = xi.petId.FENRIR,
                notMatching = xi.petId.GARUDA,
            },
        }
        for _, case in ipairs(cases) do
            player:setWeather(case.weather)
            player:despawnPet()
            -- Reduced cost with avatar matching day
            player:spawnPet(case.matching)
            local cost = (specialBaseCost[case.matching] or 13) - 3
            verifyPerpetuationCost(player, cost)
            player:despawnPet()
            -- Regular cost with avatar not matching day
            player:spawnPet(case.notMatching)
            cost = specialBaseCost[case.notMatching] or 13
            verifyPerpetuationCost(player, cost)
        end
    end)

    it('is 0 with Astral Flow', function()
        player:spawnPet(xi.petId.IFRIT)
        player.actions:useAbility(player, xi.jobAbility.ASTRAL_FLOW)
        xi.test.world:tickEntity(player)
        verifyPerpetuationCost(player, 0)
    end)
end)
