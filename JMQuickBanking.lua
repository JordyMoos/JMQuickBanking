
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

    for index = 0, bagSize do
        _, stack, _, _, _, _ = GetItemInfo(bagId, index)
        type = GetItemType(bagId, index)
        filter = GetItemFilterTypeInfo(bagId, index)
        id = GetItemUniqueId(bagId, index)
        link = GetItemLink(bagId, index, LINK_STYLE_DEFAULT)

        d('ID:' .. id)
    end
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
