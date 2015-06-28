{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.CognitoSync.RegisterDevice
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

-- | Registers a device to receive push sync notifications.
--
-- This API can only be called with temporary credentials provided by
-- Cognito Identity. You cannot call this API with developer credentials.
--
-- <http://docs.aws.amazon.com/cognitosync/latest/APIReference/API_RegisterDevice.html>
module Network.AWS.CognitoSync.RegisterDevice
    (
    -- * Request
      RegisterDevice
    -- ** Request constructor
    , registerDevice
    -- ** Request lenses
    , rdIdentityPoolId
    , rdIdentityId
    , rdPlatform
    , rdToken

    -- * Response
    , RegisterDeviceResponse
    -- ** Response constructor
    , registerDeviceResponse
    -- ** Response lenses
    , rdrDeviceId
    , rdrStatus
    ) where

import           Network.AWS.CognitoSync.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | A request to RegisterDevice.
--
-- /See:/ 'registerDevice' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rdIdentityPoolId'
--
-- * 'rdIdentityId'
--
-- * 'rdPlatform'
--
-- * 'rdToken'
data RegisterDevice = RegisterDevice'
    { _rdIdentityPoolId :: !Text
    , _rdIdentityId     :: !Text
    , _rdPlatform       :: !Platform
    , _rdToken          :: !Text
    } deriving (Eq,Read,Show)

-- | 'RegisterDevice' smart constructor.
registerDevice :: Text -> Text -> Platform -> Text -> RegisterDevice
registerDevice pIdentityPoolId pIdentityId pPlatform pToken =
    RegisterDevice'
    { _rdIdentityPoolId = pIdentityPoolId
    , _rdIdentityId = pIdentityId
    , _rdPlatform = pPlatform
    , _rdToken = pToken
    }

-- | A name-spaced GUID (for example,
-- us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon
-- Cognito. Here, the ID of the pool that the identity belongs to.
rdIdentityPoolId :: Lens' RegisterDevice Text
rdIdentityPoolId = lens _rdIdentityPoolId (\ s a -> s{_rdIdentityPoolId = a});

-- | The unique ID for this identity.
rdIdentityId :: Lens' RegisterDevice Text
rdIdentityId = lens _rdIdentityId (\ s a -> s{_rdIdentityId = a});

-- | The SNS platform type (e.g. GCM, SDM, APNS, APNS_SANDBOX).
rdPlatform :: Lens' RegisterDevice Platform
rdPlatform = lens _rdPlatform (\ s a -> s{_rdPlatform = a});

-- | The push token.
rdToken :: Lens' RegisterDevice Text
rdToken = lens _rdToken (\ s a -> s{_rdToken = a});

instance AWSRequest RegisterDevice where
        type Sv RegisterDevice = CognitoSync
        type Rs RegisterDevice = RegisterDeviceResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 RegisterDeviceResponse' <$>
                   (x .?> "DeviceId") <*> (pure s))

instance ToHeaders RegisterDevice where
        toHeaders
          = const
              (mconcat
                 ["Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON RegisterDevice where
        toJSON RegisterDevice'{..}
          = object
              ["Platform" .= _rdPlatform, "Token" .= _rdToken]

instance ToPath RegisterDevice where
        toPath RegisterDevice'{..}
          = mconcat
              ["/identitypools/", toText _rdIdentityPoolId,
               "/identity/", toText _rdIdentityId, "/device"]

instance ToQuery RegisterDevice where
        toQuery = const mempty

-- | Response to a RegisterDevice request.
--
-- /See:/ 'registerDeviceResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rdrDeviceId'
--
-- * 'rdrStatus'
data RegisterDeviceResponse = RegisterDeviceResponse'
    { _rdrDeviceId :: !(Maybe Text)
    , _rdrStatus   :: !Status
    } deriving (Eq,Read,Show)

-- | 'RegisterDeviceResponse' smart constructor.
registerDeviceResponse :: Status -> RegisterDeviceResponse
registerDeviceResponse pStatus =
    RegisterDeviceResponse'
    { _rdrDeviceId = Nothing
    , _rdrStatus = pStatus
    }

-- | The unique ID generated for this device by Cognito.
rdrDeviceId :: Lens' RegisterDeviceResponse (Maybe Text)
rdrDeviceId = lens _rdrDeviceId (\ s a -> s{_rdrDeviceId = a});

-- | FIXME: Undocumented member.
rdrStatus :: Lens' RegisterDeviceResponse Status
rdrStatus = lens _rdrStatus (\ s a -> s{_rdrStatus = a});
