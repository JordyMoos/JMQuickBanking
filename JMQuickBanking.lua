
---
--- JMQuickBanking
---

--[[

    Variable declaration

 ]]

---
-- @field name
-- @field savedVariablesName
--
local Config = {
    name = 'JMQuickBanking',
    savedVariablesName = 'JMQuickBankingSavedVariables',
}

local SavedVariables = {}


-- QuickBankingLibrary
local QBL = {}

QBL.getItems = function (bagId)
    local items = {}
    local bagSize = GetBagSize(bagId)

--    StackBag(bagId)

    for index = 0, bagSize do
        local type = GetItemType(bagId, index)
        if type ~= ITEMTYPE_NONE then
            local name = GetItemName(bagId, index)
            local filter = GetItemFilterTypeInfo(bagId, index)
            local link = GetItemLink(bagId, index, LINK_STYLE_DEFAULT)
            local  _, stack, _, _, _, _ = GetItemInfo(bagId, index)

            table.insert(items, {
                type = type,
                name = name,
                filter = filter,
                link = link,
                stack = stack,
            })
        end
    end

--    d(items)

    return items
end


--[[

    Initialize

 ]]

---
-- Start of the addon
--
local function Initialize()
    -- Load the saved variables
    SavedVariables = ZO_SavedVars:NewAccountWide(Config.savedVariablesName, 1, nil, {
        --buyList = {},
    })
    --BuyList = SavedVariables.buyList

    EVENT_MANAGER:RegisterForEvent(Config.name, EVENT_OPEN_BANK, function () end)
    EVENT_MANAGER:RegisterForEvent(Config.name, EVENT_CLOSE_BANK, function () end)
    EVENT_MANAGER:RegisterForEvent(Config.name, EVENT_BANK_IS_FULL, function () end)
    EVENT_MANAGER:RegisterForEvent(Config.name, EVENT_INVENTORY_BOUGHT_BANK_SPACE, function () end)

    zo_callLater(function ()
        QBL.getItems(BAG_BACKPACK)
    end, 5000)
end


--[[

    Api

 ]]

---
-- Making some functions public
--
JMQuickBanking = {
    -- No API calls yet
}

--[[

    Events

 ]]

--- Adding the initialize handler
EVENT_MANAGER:RegisterForEvent(
    Config.name,
    EVENT_ADD_ON_LOADED,
    function (event, addonName)
        if addonName ~= Config.name then
            return
        end

        Initialize()
        EVENT_MANAGER:UnregisterForEvent(Config.name, EVENT_ADD_ON_LOADED)
    end
)
