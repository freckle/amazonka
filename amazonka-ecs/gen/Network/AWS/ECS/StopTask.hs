{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.ECS.StopTask
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

-- | Stops a running task.
--
-- <http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StopTask.html>
module Network.AWS.ECS.StopTask
    (
    -- * Request
      StopTask
    -- ** Request constructor
    , stopTask
    -- ** Request lenses
    , stCluster
    , stTask

    -- * Response
    , StopTaskResponse
    -- ** Response constructor
    , stopTaskResponse
    -- ** Response lenses
    , stoTask
    , stoStatus
    ) where

import           Network.AWS.ECS.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'stopTask' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'stCluster'
--
-- * 'stTask'
data StopTask = StopTask'
    { _stCluster :: !(Maybe Text)
    , _stTask    :: !Text
    } deriving (Eq,Read,Show)

-- | 'StopTask' smart constructor.
stopTask :: Text -> StopTask
stopTask pTask =
    StopTask'
    { _stCluster = Nothing
    , _stTask = pTask
    }

-- | The short name or full Amazon Resource Name (ARN) of the cluster that
-- hosts the task you want to stop. If you do not specify a cluster, the
-- default cluster is assumed..
stCluster :: Lens' StopTask (Maybe Text)
stCluster = lens _stCluster (\ s a -> s{_stCluster = a});

-- | The task UUIDs or full Amazon Resource Name (ARN) entry of the task you
-- would like to stop.
stTask :: Lens' StopTask Text
stTask = lens _stTask (\ s a -> s{_stTask = a});

instance AWSRequest StopTask where
        type Sv StopTask = ECS
        type Rs StopTask = StopTaskResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 StopTaskResponse' <$> (x .?> "task") <*> (pure s))

instance ToHeaders StopTask where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AmazonEC2ContainerServiceV20141113.StopTask" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON StopTask where
        toJSON StopTask'{..}
          = object ["cluster" .= _stCluster, "task" .= _stTask]

instance ToPath StopTask where
        toPath = const "/"

instance ToQuery StopTask where
        toQuery = const mempty

-- | /See:/ 'stopTaskResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'stoTask'
--
-- * 'stoStatus'
data StopTaskResponse = StopTaskResponse'
    { _stoTask   :: !(Maybe Task)
    , _stoStatus :: !Status
    } deriving (Eq,Read,Show)

-- | 'StopTaskResponse' smart constructor.
stopTaskResponse :: Status -> StopTaskResponse
stopTaskResponse pStatus =
    StopTaskResponse'
    { _stoTask = Nothing
    , _stoStatus = pStatus
    }

-- | FIXME: Undocumented member.
stoTask :: Lens' StopTaskResponse (Maybe Task)
stoTask = lens _stoTask (\ s a -> s{_stoTask = a});

-- | FIXME: Undocumented member.
stoStatus :: Lens' StopTaskResponse Status
stoStatus = lens _stoStatus (\ s a -> s{_stoStatus = a});
