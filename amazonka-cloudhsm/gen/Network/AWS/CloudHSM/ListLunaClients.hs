{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.CloudHSM.ListLunaClients
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Lists all of the clients.
--
-- This operation supports pagination with the use of the /NextToken/
-- member. If more results are available, the /NextToken/ member of the
-- response contains a token that you pass in the next call to
-- ListLunaClients to retrieve the next set of items.
--
-- <http://docs.aws.amazon.com/cloudhsm/latest/dg/API_ListLunaClients.html>
module Network.AWS.CloudHSM.ListLunaClients
    (
    -- * Request
      ListLunaClients
    -- ** Request constructor
    , listLunaClients
    -- ** Request lenses
    , llcNextToken

    -- * Response
    , ListLunaClientsResponse
    -- ** Response constructor
    , listLunaClientsResponse
    -- ** Response lenses
    , llcrNextToken
    , llcrClientList
    , llcrStatus
    ) where

import           Network.AWS.CloudHSM.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'listLunaClients' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'llcNextToken'
newtype ListLunaClients = ListLunaClients'
    { _llcNextToken :: Maybe Text
    } deriving (Eq,Read,Show)

-- | 'ListLunaClients' smart constructor.
listLunaClients :: ListLunaClients
listLunaClients =
    ListLunaClients'
    { _llcNextToken = Nothing
    }

-- | The /NextToken/ value from a previous call to ListLunaClients. Pass null
-- if this is the first call.
llcNextToken :: Lens' ListLunaClients (Maybe Text)
llcNextToken = lens _llcNextToken (\ s a -> s{_llcNextToken = a});

instance AWSRequest ListLunaClients where
        type Sv ListLunaClients = CloudHSM
        type Rs ListLunaClients = ListLunaClientsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListLunaClientsResponse' <$>
                   (x .?> "NextToken") <*>
                     (x .?> "ClientList" .!@ mempty)
                     <*> (pure s))

instance ToHeaders ListLunaClients where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("CloudHsmFrontendService.ListLunaClients" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListLunaClients where
        toJSON ListLunaClients'{..}
          = object ["NextToken" .= _llcNextToken]

instance ToPath ListLunaClients where
        toPath = const "/"

instance ToQuery ListLunaClients where
        toQuery = const mempty

-- | /See:/ 'listLunaClientsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'llcrNextToken'
--
-- * 'llcrClientList'
--
-- * 'llcrStatus'
data ListLunaClientsResponse = ListLunaClientsResponse'
    { _llcrNextToken  :: !(Maybe Text)
    , _llcrClientList :: ![Text]
    , _llcrStatus     :: !Status
    } deriving (Eq,Read,Show)

-- | 'ListLunaClientsResponse' smart constructor.
listLunaClientsResponse :: Status -> ListLunaClientsResponse
listLunaClientsResponse pStatus =
    ListLunaClientsResponse'
    { _llcrNextToken = Nothing
    , _llcrClientList = mempty
    , _llcrStatus = pStatus
    }

-- | If not null, more results are available. Pass this to ListLunaClients to
-- retrieve the next set of items.
llcrNextToken :: Lens' ListLunaClientsResponse (Maybe Text)
llcrNextToken = lens _llcrNextToken (\ s a -> s{_llcrNextToken = a});

-- | The list of clients.
llcrClientList :: Lens' ListLunaClientsResponse [Text]
llcrClientList = lens _llcrClientList (\ s a -> s{_llcrClientList = a});

-- | FIXME: Undocumented member.
llcrStatus :: Lens' ListLunaClientsResponse Status
llcrStatus = lens _llcrStatus (\ s a -> s{_llcrStatus = a});
