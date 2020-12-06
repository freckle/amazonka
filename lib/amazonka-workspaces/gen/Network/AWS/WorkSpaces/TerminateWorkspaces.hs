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
-- Module      : Network.AWS.WorkSpaces.TerminateWorkspaces
-- Copyright   : (c) 2013-2020 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Terminates the specified WorkSpaces.
--
--
-- /Important:/ Terminating a WorkSpace is a permanent action and cannot be undone. The user's data is destroyed. If you need to archive any user data, contact AWS Support before terminating the WorkSpace.
--
-- You can terminate a WorkSpace that is in any state except @SUSPENDED@ .
--
-- This operation is asynchronous and returns before the WorkSpaces have been completely terminated. After a WorkSpace is terminated, the @TERMINATED@ state is returned only briefly before the WorkSpace directory metadata is cleaned up, so this state is rarely returned. To confirm that a WorkSpace is terminated, check for the WorkSpace ID by using <https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaces.html DescribeWorkSpaces> . If the WorkSpace ID isn't returned, then the WorkSpace has been successfully terminated.
module Network.AWS.WorkSpaces.TerminateWorkspaces
  ( -- * Creating a Request
    terminateWorkspaces,
    TerminateWorkspaces,

    -- * Request Lenses
    twTerminateWorkspaceRequests,

    -- * Destructuring the Response
    terminateWorkspacesResponse,
    TerminateWorkspacesResponse,

    -- * Response Lenses
    twrsFailedRequests,
    twrsResponseStatus,
  )
where

import Network.AWS.Lens
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.WorkSpaces.Types

-- | /See:/ 'terminateWorkspaces' smart constructor.
newtype TerminateWorkspaces = TerminateWorkspaces'
  { _twTerminateWorkspaceRequests ::
      List1 TerminateRequest
  }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'TerminateWorkspaces' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'twTerminateWorkspaceRequests' - The WorkSpaces to terminate. You can specify up to 25 WorkSpaces.
terminateWorkspaces ::
  -- | 'twTerminateWorkspaceRequests'
  NonEmpty TerminateRequest ->
  TerminateWorkspaces
terminateWorkspaces pTerminateWorkspaceRequests_ =
  TerminateWorkspaces'
    { _twTerminateWorkspaceRequests =
        _List1 # pTerminateWorkspaceRequests_
    }

-- | The WorkSpaces to terminate. You can specify up to 25 WorkSpaces.
twTerminateWorkspaceRequests :: Lens' TerminateWorkspaces (NonEmpty TerminateRequest)
twTerminateWorkspaceRequests = lens _twTerminateWorkspaceRequests (\s a -> s {_twTerminateWorkspaceRequests = a}) . _List1

instance AWSRequest TerminateWorkspaces where
  type Rs TerminateWorkspaces = TerminateWorkspacesResponse
  request = postJSON workSpaces
  response =
    receiveJSON
      ( \s h x ->
          TerminateWorkspacesResponse'
            <$> (x .?> "FailedRequests" .!@ mempty) <*> (pure (fromEnum s))
      )

instance Hashable TerminateWorkspaces

instance NFData TerminateWorkspaces

instance ToHeaders TerminateWorkspaces where
  toHeaders =
    const
      ( mconcat
          [ "X-Amz-Target"
              =# ("WorkspacesService.TerminateWorkspaces" :: ByteString),
            "Content-Type" =# ("application/x-amz-json-1.1" :: ByteString)
          ]
      )

instance ToJSON TerminateWorkspaces where
  toJSON TerminateWorkspaces' {..} =
    object
      ( catMaybes
          [ Just
              ("TerminateWorkspaceRequests" .= _twTerminateWorkspaceRequests)
          ]
      )

instance ToPath TerminateWorkspaces where
  toPath = const "/"

instance ToQuery TerminateWorkspaces where
  toQuery = const mempty

-- | /See:/ 'terminateWorkspacesResponse' smart constructor.
data TerminateWorkspacesResponse = TerminateWorkspacesResponse'
  { _twrsFailedRequests ::
      !( Maybe
           [FailedWorkspaceChangeRequest]
       ),
    _twrsResponseStatus :: !Int
  }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'TerminateWorkspacesResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'twrsFailedRequests' - Information about the WorkSpaces that could not be terminated.
--
-- * 'twrsResponseStatus' - -- | The response status code.
terminateWorkspacesResponse ::
  -- | 'twrsResponseStatus'
  Int ->
  TerminateWorkspacesResponse
terminateWorkspacesResponse pResponseStatus_ =
  TerminateWorkspacesResponse'
    { _twrsFailedRequests = Nothing,
      _twrsResponseStatus = pResponseStatus_
    }

-- | Information about the WorkSpaces that could not be terminated.
twrsFailedRequests :: Lens' TerminateWorkspacesResponse [FailedWorkspaceChangeRequest]
twrsFailedRequests = lens _twrsFailedRequests (\s a -> s {_twrsFailedRequests = a}) . _Default . _Coerce

-- | -- | The response status code.
twrsResponseStatus :: Lens' TerminateWorkspacesResponse Int
twrsResponseStatus = lens _twrsResponseStatus (\s a -> s {_twrsResponseStatus = a})

instance NFData TerminateWorkspacesResponse