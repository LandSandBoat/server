-----------------------------------
-- Einherjar: Chambers management
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

local chambersByTier = {
    [xi.einherjar.wing.WING_1] = {
        {
            id     = xi.einherjar.chamber.ROSSWEISS,
            ki     = xi.ki.ROSSWEISSES_FEATHER,
            menu   = 0x2,
            center = { 401.1, -216, 40.6, 28 },
            ichor  = 960,
        },
        {
            id     = xi.einherjar.chamber.GRIMGERDE,
            ki     = xi.ki.GRIMGERDES_FEATHER,
            menu   = 0x4,
            center = { 159.6, -196, -41.4, 220 },
            ichor  = 960,
        },
        {
            id     = xi.einherjar.chamber.SIEGRUNE,
            ki     = xi.ki.SIEGRUNES_FEATHER,
            menu   = 0x8,
            center = { 78.5, -176, -281, 221 },
            ichor  = 960,
        },
    },
    [xi.einherjar.wing.WING_2] = {
        {
            id     = xi.einherjar.chamber.WALTRAUTE,
            ki     = xi.ki.WALTRAUTES_FEATHER,
            menu   = 0x10,
            center = { -197.32, -146, -439.5, 218 },
            ichor  = 1440,
        },
        {
            id     = xi.einherjar.chamber.HELMWIGE,
            ki     = xi.ki.HELMWIGES_FEATHER,
            menu   = 0x20,
            center = { -437.3986, -126.0, -281.89, 34 },
            ichor  = 1440,
        },
        {
            id     = xi.einherjar.chamber.SCHWERTLEITE,
            ki     = xi.ki.SCHWERTLEITES_FEATHER,
            menu   = 0x40,
            center = { -678, -106, -120, 28 },
            ichor  = 1440,
        },
    },
    [xi.einherjar.wing.WING_3] = {
        {
            id     = xi.einherjar.chamber.ORTLINDE,
            ki     = xi.ki.ORTLINDES_FEATHER,
            menu   = 0x80,
            center = { -519.36, -66, 158.96, 56 },
            ichor  = 1920,
        },
        {
            id     = xi.einherjar.chamber.GERHILDE,
            ki     = xi.ki.GERHILDES_FEATHER,
            menu   = 0x100,
            center = { -360.81, -46, 398.3684, 96 },
            ichor  = 1920,
        },
        {
            id     = xi.einherjar.chamber.BRUNNHILDE,
            ki     = xi.ki.BRUNHILDES_FEATHER,
            menu   = 0x200,
            center = { -82.26, -6, 242.05, 159 },
            ichor  = 1920,
        },
    },
    [xi.einherjar.wing.ODIN] = {
        {
            id     = xi.einherjar.chamber.ODIN,
            ki     = 0,
            menu   = 0x400,
            center = { -277.4, 34, -38.15, 222 },
            ichor  = 2880,
        },
        {
            id     = xi.einherjar.chamber.ODIN_II,
            ki     = 0,
            menu   = 0x1000,
            center = { -277.4, 34, -38.15, 222 },
            ichor  = 3600,
        },
    },
}

xi.einherjar.chambers = {
    [xi.einherjar.chamber.ROSSWEISS]    = chambersByTier[xi.einherjar.wing.WING_1][1],
    [xi.einherjar.chamber.GRIMGERDE]    = chambersByTier[xi.einherjar.wing.WING_1][2],
    [xi.einherjar.chamber.SIEGRUNE]     = chambersByTier[xi.einherjar.wing.WING_1][3],
    [xi.einherjar.chamber.WALTRAUTE]    = chambersByTier[xi.einherjar.wing.WING_2][1],
    [xi.einherjar.chamber.HELMWIGE]     = chambersByTier[xi.einherjar.wing.WING_2][2],
    [xi.einherjar.chamber.SCHWERTLEITE] = chambersByTier[xi.einherjar.wing.WING_2][3],
    [xi.einherjar.chamber.ORTLINDE]     = chambersByTier[xi.einherjar.wing.WING_3][1],
    [xi.einherjar.chamber.GERHILDE]     = chambersByTier[xi.einherjar.wing.WING_3][2],
    [xi.einherjar.chamber.BRUNNHILDE]   = chambersByTier[xi.einherjar.wing.WING_3][3],
    [xi.einherjar.chamber.ODIN]         = chambersByTier[xi.einherjar.wing.ODIN][1],
}

xi.einherjar.isLockedOut = function(player)
    local lockout = player:getCharVar('[ein]lockout')
    if lockout == 0 then
        return 0
    end

    return math.ceil((lockout - os.time()) / 2088) -- Vanadiel days
end

-- Bitmask of chambers the player has access to
-- Player must own all key items from previous tier to access the next tier
-- Wing 1 is always accessible
xi.einherjar.getChambersMenu = function(player)
    local mask = 0xFF0
    local wings = {
        xi.einherjar.wing.WING_1,
        xi.einherjar.wing.WING_2,
        xi.einherjar.wing.WING_3,
        xi.einherjar.wing.ODIN
    }

    for i = 1, #wings do
        local tierChambers = chambersByTier[wings[i]]
        local nextTierChambers = chambersByTier[wings[i + 1]]

        -- Check if player owns all key items in the current tier
        local ownsAllCurrent = true
        for _, chamber in ipairs(tierChambers) do
            if not player:hasKeyItem(chamber.ki) then
                ownsAllCurrent = false
                break
            end
        end

        if not ownsAllCurrent then
            break
        end

        if nextTierChambers then
            for _, chamber in ipairs(nextTierChambers) do
                mask = bit.band(mask, bit.bnot(bit.lshift(1, chamber.id)))
            end
        end
    end

    return mask
end
