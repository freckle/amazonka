{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CognitoIdentityProvider.InitiateAuth
-- Copyright   : (c) 2013-2020 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Initiates the authentication flow.
module Network.AWS.CognitoIdentityProvider.InitiateAuth
  ( -- * Creating a Request
    initiateAuth,
    InitiateAuth,

    -- * Request Lenses
    iaClientMetadata,
    iaAnalyticsMetadata,
    iaUserContextData,
    iaAuthParameters,
    iaAuthFlow,
    iaClientId,

    -- * Destructuring the Response
    initiateAuthResponse,
    InitiateAuthResponse,

    -- * Response Lenses
    iarsChallengeName,
    iarsChallengeParameters,
    iarsAuthenticationResult,
    iarsSession,
    iarsResponseStatus,
  )
where

import Network.AWS.CognitoIdentityProvider.Types
import Network.AWS.Lens
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | Initiates the authentication request.
--
--
--
-- /See:/ 'initiateAuth' smart constructor.
data InitiateAuth = InitiateAuth'
  { _iaClientMetadata ::
      !(Maybe (Map Text (Text))),
    _iaAnalyticsMetadata :: !(Maybe AnalyticsMetadataType),
    _iaUserContextData :: !(Maybe UserContextDataType),
    _iaAuthParameters :: !(Maybe (Sensitive (Map Text (Text)))),
    _iaAuthFlow :: !AuthFlowType,
    _iaClientId :: !(Sensitive Text)
  }
  deriving (Eq, Show, Data, Typeable, Generic)

-- | Creates a value of 'InitiateAuth' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'iaClientMetadata' - A map of custom key-value pairs that you can provide as input for certain custom workflows that this action triggers. You create custom workflows by assigning AWS Lambda functions to user pool triggers. When you use the InitiateAuth API action, Amazon Cognito invokes the AWS Lambda functions that are specified for various triggers. The ClientMetadata value is passed as input to the functions for only the following triggers:     * Pre signup     * Pre authentication     * User migration When Amazon Cognito invokes the functions for these triggers, it passes a JSON payload, which the function receives as input. This payload contains a @validationData@ attribute, which provides the data that you assigned to the ClientMetadata parameter in your InitiateAuth request. In your function code in AWS Lambda, you can process the @validationData@ value to enhance your workflow for your specific needs. When you use the InitiateAuth API action, Amazon Cognito also invokes the functions for the following triggers, but it does not provide the ClientMetadata value as input:     * Post authentication     * Custom message     * Pre token generation     * Create auth challenge     * Define auth challenge     * Verify auth challenge For more information, see <https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html Customizing User Pool Workflows with Lambda Triggers> in the /Amazon Cognito Developer Guide/ .
--
-- * 'iaAnalyticsMetadata' - The Amazon Pinpoint analytics metadata for collecting metrics for @InitiateAuth@ calls.
--
-- * 'iaUserContextData' - Contextual data such as the user's device fingerprint, IP address, or location used for evaluating the risk of an unexpected event by Amazon Cognito advanced security.
--
-- * 'iaAuthParameters' - The authentication parameters. These are inputs corresponding to the @AuthFlow@ that you are invoking. The required values depend on the value of @AuthFlow@ :     * For @USER_SRP_AUTH@ : @USERNAME@ (required), @SRP_A@ (required), @SECRET_HASH@ (required if the app client is configured with a client secret), @DEVICE_KEY@ .     * For @REFRESH_TOKEN_AUTH/REFRESH_TOKEN@ : @REFRESH_TOKEN@ (required), @SECRET_HASH@ (required if the app client is configured with a client secret), @DEVICE_KEY@ .     * For @CUSTOM_AUTH@ : @USERNAME@ (required), @SECRET_HASH@ (if app client is configured with client secret), @DEVICE_KEY@ . To start the authentication flow with password verification, include @ChallengeName: SRP_A@ and @SRP_A: (The SRP_A Value)@ .
--
-- * 'iaAuthFlow' - The authentication flow for this call to execute. The API action will depend on this value. For example:      * @REFRESH_TOKEN_AUTH@ will take in a valid refresh token and return new tokens.     * @USER_SRP_AUTH@ will take in @USERNAME@ and @SRP_A@ and return the SRP variables to be used for next challenge execution.     * @USER_PASSWORD_AUTH@ will take in @USERNAME@ and @PASSWORD@ and return the next challenge or tokens. Valid values include:     * @USER_SRP_AUTH@ : Authentication flow for the Secure Remote Password (SRP) protocol.     * @REFRESH_TOKEN_AUTH@ /@REFRESH_TOKEN@ : Authentication flow for refreshing the access token and ID token by supplying a valid refresh token.     * @CUSTOM_AUTH@ : Custom authentication flow.     * @USER_PASSWORD_AUTH@ : Non-SRP authentication flow; USERNAME and PASSWORD are passed directly. If a user migration Lambda trigger is set, this flow will invoke the user migration Lambda if the USERNAME is not found in the user pool.      * @ADMIN_USER_PASSWORD_AUTH@ : Admin-based user password authentication. This replaces the @ADMIN_NO_SRP_AUTH@ authentication flow. In this flow, Cognito receives the password in the request instead of using the SRP process to verify passwords. @ADMIN_NO_SRP_AUTH@ is not a valid value.
--
-- * 'iaClientId' - The app client ID.
initiateAuth ::
  -- | 'iaAuthFlow'
  AuthFlowType ->
  -- | 'iaClientId'
  Text ->
  InitiateAuth
initiateAuth pAuthFlow_ pClientId_ =
  InitiateAuth'
    { _iaClientMetadata = Nothing,
      _iaAnalyticsMetadata = Nothing,
      _iaUserContextData = Nothing,
      _iaAuthParameters = Nothing,
      _iaAuthFlow = pAuthFlow_,
      _iaClientId = _Sensitive # pClientId_
    }

-- | A map of custom key-value pairs that you can provide as input for certain custom workflows that this action triggers. You create custom workflows by assigning AWS Lambda functions to user pool triggers. When you use the InitiateAuth API action, Amazon Cognito invokes the AWS Lambda functions that are specified for various triggers. The ClientMetadata value is passed as input to the functions for only the following triggers:     * Pre signup     * Pre authentication     * User migration When Amazon Cognito invokes the functions for these triggers, it passes a JSON payload, which the function receives as input. This payload contains a @validationData@ attribute, which provides the data that you assigned to the ClientMetadata parameter in your InitiateAuth request. In your function code in AWS Lambda, you can process the @validationData@ value to enhance your workflow for your specific needs. When you use the InitiateAuth API action, Amazon Cognito also invokes the functions for the following triggers, but it does not provide the ClientMetadata value as input:     * Post authentication     * Custom message     * Pre token generation     * Create auth challenge     * Define auth challenge     * Verify auth challenge For more information, see <https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html Customizing User Pool Workflows with Lambda Triggers> in the /Amazon Cognito Developer Guide/ .
iaClientMetadata :: Lens' InitiateAuth (HashMap Text (Text))
iaClientMetadata = lens _iaClientMetadata (\s a -> s {_iaClientMetadata = a}) . _Default . _Map

-- | The Amazon Pinpoint analytics metadata for collecting metrics for @InitiateAuth@ calls.
iaAnalyticsMetadata :: Lens' InitiateAuth (Maybe AnalyticsMetadataType)
iaAnalyticsMetadata = lens _iaAnalyticsMetadata (\s a -> s {_iaAnalyticsMetadata = a})

-- | Contextual data such as the user's device fingerprint, IP address, or location used for evaluating the risk of an unexpected event by Amazon Cognito advanced security.
iaUserContextData :: Lens' InitiateAuth (Maybe UserContextDataType)
iaUserContextData = lens _iaUserContextData (\s a -> s {_iaUserContextData = a})

-- | The authentication parameters. These are inputs corresponding to the @AuthFlow@ that you are invoking. The required values depend on the value of @AuthFlow@ :     * For @USER_SRP_AUTH@ : @USERNAME@ (required), @SRP_A@ (required), @SECRET_HASH@ (required if the app client is configured with a client secret), @DEVICE_KEY@ .     * For @REFRESH_TOKEN_AUTH/REFRESH_TOKEN@ : @REFRESH_TOKEN@ (required), @SECRET_HASH@ (required if the app client is configured with a client secret), @DEVICE_KEY@ .     * For @CUSTOM_AUTH@ : @USERNAME@ (required), @SECRET_HASH@ (if app client is configured with client secret), @DEVICE_KEY@ . To start the authentication flow with password verification, include @ChallengeName: SRP_A@ and @SRP_A: (The SRP_A Value)@ .
iaAuthParameters :: Lens' InitiateAuth (Maybe (HashMap Text (Text)))
iaAuthParameters = lens _iaAuthParameters (\s a -> s {_iaAuthParameters = a}) . mapping (_Sensitive . _Map)

-- | The authentication flow for this call to execute. The API action will depend on this value. For example:      * @REFRESH_TOKEN_AUTH@ will take in a valid refresh token and return new tokens.     * @USER_SRP_AUTH@ will take in @USERNAME@ and @SRP_A@ and return the SRP variables to be used for next challenge execution.     * @USER_PASSWORD_AUTH@ will take in @USERNAME@ and @PASSWORD@ and return the next challenge or tokens. Valid values include:     * @USER_SRP_AUTH@ : Authentication flow for the Secure Remote Password (SRP) protocol.     * @REFRESH_TOKEN_AUTH@ /@REFRESH_TOKEN@ : Authentication flow for refreshing the access token and ID token by supplying a valid refresh token.     * @CUSTOM_AUTH@ : Custom authentication flow.     * @USER_PASSWORD_AUTH@ : Non-SRP authentication flow; USERNAME and PASSWORD are passed directly. If a user migration Lambda trigger is set, this flow will invoke the user migration Lambda if the USERNAME is not found in the user pool.      * @ADMIN_USER_PASSWORD_AUTH@ : Admin-based user password authentication. This replaces the @ADMIN_NO_SRP_AUTH@ authentication flow. In this flow, Cognito receives the password in the request instead of using the SRP process to verify passwords. @ADMIN_NO_SRP_AUTH@ is not a valid value.
iaAuthFlow :: Lens' InitiateAuth AuthFlowType
iaAuthFlow = lens _iaAuthFlow (\s a -> s {_iaAuthFlow = a})

-- | The app client ID.
iaClientId :: Lens' InitiateAuth Text
iaClientId = lens _iaClientId (\s a -> s {_iaClientId = a}) . _Sensitive

instance AWSRequest InitiateAuth where
  type Rs InitiateAuth = InitiateAuthResponse
  request = postJSON cognitoIdentityProvider
  response =
    receiveJSON
      ( \s h x ->
          InitiateAuthResponse'
            <$> (x .?> "ChallengeName")
            <*> (x .?> "ChallengeParameters" .!@ mempty)
            <*> (x .?> "AuthenticationResult")
            <*> (x .?> "Session")
            <*> (pure (fromEnum s))
      )

instance Hashable InitiateAuth

instance NFData InitiateAuth

instance ToHeaders InitiateAuth where
  toHeaders =
    const
      ( mconcat
          [ "X-Amz-Target"
              =# ("AWSCognitoIdentityProviderService.InitiateAuth" :: ByteString),
            "Content-Type" =# ("application/x-amz-json-1.1" :: ByteString)
          ]
      )

instance ToJSON InitiateAuth where
  toJSON InitiateAuth' {..} =
    object
      ( catMaybes
          [ ("ClientMetadata" .=) <$> _iaClientMetadata,
            ("AnalyticsMetadata" .=) <$> _iaAnalyticsMetadata,
            ("UserContextData" .=) <$> _iaUserContextData,
            ("AuthParameters" .=) <$> _iaAuthParameters,
            Just ("AuthFlow" .= _iaAuthFlow),
            Just ("ClientId" .= _iaClientId)
          ]
      )

instance ToPath InitiateAuth where
  toPath = const "/"

instance ToQuery InitiateAuth where
  toQuery = const mempty

-- | Initiates the authentication response.
--
--
--
-- /See:/ 'initiateAuthResponse' smart constructor.
data InitiateAuthResponse = InitiateAuthResponse'
  { _iarsChallengeName ::
      !(Maybe ChallengeNameType),
    _iarsChallengeParameters ::
      !(Maybe (Map Text (Text))),
    _iarsAuthenticationResult ::
      !(Maybe AuthenticationResultType),
    _iarsSession :: !(Maybe Text),
    _iarsResponseStatus :: !Int
  }
  deriving (Eq, Show, Data, Typeable, Generic)

-- | Creates a value of 'InitiateAuthResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'iarsChallengeName' - The name of the challenge which you are responding to with this call. This is returned to you in the @AdminInitiateAuth@ response if you need to pass another challenge. Valid values include the following. Note that all of these challenges require @USERNAME@ and @SECRET_HASH@ (if applicable) in the parameters.     * @SMS_MFA@ : Next challenge is to supply an @SMS_MFA_CODE@ , delivered via SMS.     * @PASSWORD_VERIFIER@ : Next challenge is to supply @PASSWORD_CLAIM_SIGNATURE@ , @PASSWORD_CLAIM_SECRET_BLOCK@ , and @TIMESTAMP@ after the client-side SRP calculations.     * @CUSTOM_CHALLENGE@ : This is returned if your custom authentication flow determines that the user should pass another challenge before tokens are issued.     * @DEVICE_SRP_AUTH@ : If device tracking was enabled on your user pool and the previous challenges were passed, this challenge is returned so that Amazon Cognito can start tracking this device.     * @DEVICE_PASSWORD_VERIFIER@ : Similar to @PASSWORD_VERIFIER@ , but for devices only.     * @NEW_PASSWORD_REQUIRED@ : For users which are required to change their passwords after successful first login. This challenge should be passed with @NEW_PASSWORD@ and any other required attributes.
--
-- * 'iarsChallengeParameters' - The challenge parameters. These are returned to you in the @InitiateAuth@ response if you need to pass another challenge. The responses in this parameter should be used to compute inputs to the next call (@RespondToAuthChallenge@ ).  All challenges require @USERNAME@ and @SECRET_HASH@ (if applicable).
--
-- * 'iarsAuthenticationResult' - The result of the authentication response. This is only returned if the caller does not need to pass another challenge. If the caller does need to pass another challenge before it gets tokens, @ChallengeName@ , @ChallengeParameters@ , and @Session@ are returned.
--
-- * 'iarsSession' - The session which should be passed both ways in challenge-response calls to the service. If the caller needs to go through another challenge, they return a session with other challenge parameters. This session should be passed as it is to the next @RespondToAuthChallenge@ API call.
--
-- * 'iarsResponseStatus' - -- | The response status code.
initiateAuthResponse ::
  -- | 'iarsResponseStatus'
  Int ->
  InitiateAuthResponse
initiateAuthResponse pResponseStatus_ =
  InitiateAuthResponse'
    { _iarsChallengeName = Nothing,
      _iarsChallengeParameters = Nothing,
      _iarsAuthenticationResult = Nothing,
      _iarsSession = Nothing,
      _iarsResponseStatus = pResponseStatus_
    }

-- | The name of the challenge which you are responding to with this call. This is returned to you in the @AdminInitiateAuth@ response if you need to pass another challenge. Valid values include the following. Note that all of these challenges require @USERNAME@ and @SECRET_HASH@ (if applicable) in the parameters.     * @SMS_MFA@ : Next challenge is to supply an @SMS_MFA_CODE@ , delivered via SMS.     * @PASSWORD_VERIFIER@ : Next challenge is to supply @PASSWORD_CLAIM_SIGNATURE@ , @PASSWORD_CLAIM_SECRET_BLOCK@ , and @TIMESTAMP@ after the client-side SRP calculations.     * @CUSTOM_CHALLENGE@ : This is returned if your custom authentication flow determines that the user should pass another challenge before tokens are issued.     * @DEVICE_SRP_AUTH@ : If device tracking was enabled on your user pool and the previous challenges were passed, this challenge is returned so that Amazon Cognito can start tracking this device.     * @DEVICE_PASSWORD_VERIFIER@ : Similar to @PASSWORD_VERIFIER@ , but for devices only.     * @NEW_PASSWORD_REQUIRED@ : For users which are required to change their passwords after successful first login. This challenge should be passed with @NEW_PASSWORD@ and any other required attributes.
iarsChallengeName :: Lens' InitiateAuthResponse (Maybe ChallengeNameType)
iarsChallengeName = lens _iarsChallengeName (\s a -> s {_iarsChallengeName = a})

-- | The challenge parameters. These are returned to you in the @InitiateAuth@ response if you need to pass another challenge. The responses in this parameter should be used to compute inputs to the next call (@RespondToAuthChallenge@ ).  All challenges require @USERNAME@ and @SECRET_HASH@ (if applicable).
iarsChallengeParameters :: Lens' InitiateAuthResponse (HashMap Text (Text))
iarsChallengeParameters = lens _iarsChallengeParameters (\s a -> s {_iarsChallengeParameters = a}) . _Default . _Map

-- | The result of the authentication response. This is only returned if the caller does not need to pass another challenge. If the caller does need to pass another challenge before it gets tokens, @ChallengeName@ , @ChallengeParameters@ , and @Session@ are returned.
iarsAuthenticationResult :: Lens' InitiateAuthResponse (Maybe AuthenticationResultType)
iarsAuthenticationResult = lens _iarsAuthenticationResult (\s a -> s {_iarsAuthenticationResult = a})

-- | The session which should be passed both ways in challenge-response calls to the service. If the caller needs to go through another challenge, they return a session with other challenge parameters. This session should be passed as it is to the next @RespondToAuthChallenge@ API call.
iarsSession :: Lens' InitiateAuthResponse (Maybe Text)
iarsSession = lens _iarsSession (\s a -> s {_iarsSession = a})

-- | -- | The response status code.
iarsResponseStatus :: Lens' InitiateAuthResponse Int
iarsResponseStatus = lens _iarsResponseStatus (\s a -> s {_iarsResponseStatus = a})

instance NFData InitiateAuthResponse